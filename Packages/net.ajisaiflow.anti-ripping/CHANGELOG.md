# Changelog — Anti-Ripping

All notable changes to this VPM package.

## [0.32.3] — 2026-05-05 (Phase 1 alpha hotfix #2)

### Fixed

- **UniversalRewrite mode で encryption は成功するが decode が失敗する致死 bug**: `TransformLtsPassContent` で `ApplyUniversalRewriteIfEnabled` を `InjectHookIntoHlslInclude` の **後** に呼んでいたため、 emit したばかりの OVERRIDE_MAIN macro 内部の `LIL_SAMPLE_2D_LOD(_MainTex, ...)` が rewriter に wrap されて `_AR_DecodedSample(LIL_SAMPLE_2D_LOD(_MainTex, ...), ...)` になっていた。 これで `_AR_DecodedSample` の decode 後に OVERRIDE_MAIN body の自前 XOR decode が **二重適用** され、 結果として **完全 noise** が描画されていた (= 「テクスチャは難読化されたが復元失敗」 の真因)。
- **修正**: rewriter 適用を `InjectHookIntoHlslInclude` の **前** に移動。 元 lts.shader / ltspass.shader 内に LIL_SAMPLE_2D 呼出は 0 件 (Phase 1 では Includes/ recursive walk 未実装) のため、 rewriter は実質 no-op となり、 後で注入される OVERRIDE_* 内部 sample は touched されない。

## [0.32.2] — 2026-05-05 (Phase 1 alpha hotfix)

### Fixed

- **UniversalRewrite mode で encryption が完全に skip されていた致死 bug**: 2 つの根本原因を fix:
  1. **Import 順序 bug**: `LilToonShaderInjector.GenerateLockedVariant` で lts shader を ltspass shader より先に ImportAsset していた (= UsePass 依存解決順序逆)。 Legacy mode は既存 cache file で動作回避していたが universal mode の new hash で fresh compile すると `Shader.Find` が persistent に null 返却 → fallback で original material 維持 → encryption 完全失効。
  2. **Phase 1 で OVERRIDE_* macro skip が早すぎた**: universal mode で OVERRIDE_*-per-spec macro emission を skip していたが、 Phase 1 では lilToon の `Includes/*.hlsl` 内 sample 呼出を rewrite する仕組みが未実装のため、 OVERRIDE_* skip = decode 経路完全消失 → 暗号化 texture が生 noise として render される結果に。 Phase 1 では OVERRIDE_* を **常時 emit** に戻し、 universal helper は **dead code として共存** させる (Phase 2 で Includes/ recursive walk 実装後に skip を有効化予定)。
- **Shader.Find fallback 強化**: ImportAsset 直後の Shader.Find 失敗時に `AssetDatabase.LoadAssetAtPath<Shader>(ltsOutPath)` で直接 load を試みる fallback を追加。

### Phase 1 alpha 完成度

- LegacyOverride mode: v0.31.15 完全互換 (regression なし)
- UniversalRewrite mode: 既存 3 properties (`_MainTex` / `_BumpMap` / `_AlphaMask`) に対する encryption が legacy と同等動作。 universal helper は dead code として shader 内に存在 (= Phase 2 で activate 予定)。

## [0.32.1] — 2026-05-05

### Added

- AntiRippingTagEditor の Texture Pixel Encryption section に `EncryptionMode` dropdown UI 追加。
- Strip Unencrypted Texture Refs / Acknowledge VRCFury Leak の toggle UI 追加。
- UniversalRewrite mode 選択時の HelpBox + 「対象テクスチャ」 個別 toggle の disable scope。

## [0.32.0] — 2026-05-05 (Phase 1 alpha — universal pipeline 基盤)

### Added (Phase 1: pipeline 基盤、 既存 3 properties で動作検証)

- **Universal texture encryption pipeline 基盤**: lilToon の全 .hlsl の `LIL_SAMPLE_2D[*]` 呼出を encrypted property の場合に `_AR_DecodedSample(...)` で wrap する source rewrite engine を新設。
  - `Editor/Pipeline/HlslSourceRewriter.cs`: 5 variants (LIL_SAMPLE_2D / _LOD / _BIAS / _GRAD / _ST) の regex + balanced-paren parse + comma split。 hit-miss detection で encrypted property に対する直接 sample 呼出残存を検出。
  - `Editor/Pipeline/HlslIncludeWalker.cs`: shader source からの include 関係を recursive 解決、 38 file DAG + header guard 認識。
  - `Editor/Pipeline/TexturePropertyDiscovery.cs`: source shader Properties block の全 Texture2D 宣言を regex で parse。
  - `Editor/Pipeline/EncryptionContext.cs`: encryption mode + encrypted property set + cache key + hit-miss errors の context data class。
  - `Editor/Pipeline/CacheJanitor.cs`: `Generated/Shaders/` 配下 7 日経過 stale file の build-start sweep。
- **`EncryptionMode { LegacyOverride, UniversalRewrite }` enum** を `Runtime/AntiRippingTag.cs` に追加。 default = LegacyOverride (Phase 1 では既存動作維持)。
- **`AcknowledgeVRCFuryLeak` opt-in flag**: VRCFury 検出時の build error / warning 抑制 (default OFF、 検出時に user 明示承認を要求する設計)。
- **`LilToonShaderInjector.GenerateLockedVariant(Shader, LockedShaderMode, EncryptionContext)` overload**: universal pipeline 用 API。 既存呼出 `GenerateLockedVariant(Shader, LockedShaderMode)` は backward-compat (= encContext = null で LegacyOverride 互換)。
- **`_AR_DecodedSample` HLSL helper**: fd 不参照 5 引数設計 (sampled / uv / seedLo / seedHi / texelSize / linearize) で全 lilToon variant matrix (NORMAL/LITE/MULTI/FUR/GEM/REF × Forward/Outline/Meta/Shadow) で compile 通る。 v0.31.13 emission 致死 regression を構造的回避。
- **Cache key 拡張**: encryption mode + encrypted property set hash を追加し、 universal mode で property set が違えば別 generated shader を生成 (stale cache 構造的防止)。

### Changed

- `ShaderLockPass.Run` で tag.EncryptionMode に応じて `EncryptionContext` を構築、 `LilToonShaderInjector.GenerateLockedVariant` の universal overload に渡す。
- AntiRippingPlugin.Apply 開始時に `CacheJanitor.SweepStaleFiles` を呼ぶ (= Editor 起動時 reimport 遅延 + line ending warning 緩和)。
- Apply() 開始時の log dump に `EncryptionMode` を追加。

### Phase 1 scope (= alpha 動作検証)

- `EncryptionMode = UniversalRewrite` で既存 3 properties (`_MainTex` / `_BumpMap` / `_AlphaMask`) が universal pipeline 経由でも正常動作する verification。
- HitMissErrors は warning log のみ (Phase 2+ で build error 化予定)。
- Phase 2 で emission / matcap / outline / rim / 2nd / shadow tinting visual-critical properties に拡張予定。
- Phase 3 で全 ~59 properties auto-discovery + `EncryptionMode.UniversalRewrite` を default 化予定。
- Phase 4 (v0.34.0) で legacy OVERRIDE_*-per-property 完全削除予定。

## [0.31.15] — 2026-05-05

### Fixed

- **顔 SMR (multi-material) が真っ白になる visual regression** (v0.31.14 で初めて visible 化): `StripUnencryptedTextureRefs = true` (default ON) が face material の `_EmissionMap` 等を null に剥がし、 lilToon が `_EmissionColor` (default 白) のみで描画 → 顔全体が白光。 `ShaderLockPass.s_StripPreserveList` を新設して emission / matcap / outline / rim / 2nd / shadow tinting / detail / glitter / fur 等の **major rendering texture (~50 properties)** を strip 対象外にし、 visual fidelity を維持。 これらは引き続き material から抽出可能なため leak risk は残存するが、 主要視覚要素 (`_MainTex` / `_BumpMap` / `_AlphaMask`) の暗号化は維持される。
- 経緯: v0.31.12 で導入した strip は元々 visual fidelity 損失を許容する trade-off だったが、 user の v0.31.12 testing は `enableTexturePixelEncryption=false` だったため strip が起動せず、 v0.31.13 は shader compile fail で original lilToon が走り strip 効果が無効化、 v0.31.14 で初めて「encryption 有効 + compile 成功 + strip 起動」が揃って visible 化した。
- 将来 v0.32 で各 property 専用 OVERRIDE_* macro が完成すれば、 preserve list の texture も暗号化されて strip 対象になる予定。

## [0.31.14] — 2026-05-05

### Fixed

- **致死 regression (v0.31.13)**: `_EmissionMap` 暗号化を導入した OVERRIDE_EMISSION_1ST inline が Outline / Meta / Shadow pass や LIL_LITE / LIL_MULTI variant で `fd.invLighting` / `fd.albedo` / `lilCalcBlink` / `lilBlendColor` / `LinearToGammaSpace` 等を未定義参照 → 大量 shader compile error → 全 renderer が BlendShape lock fallback → 元 shader 使用 → **全 texture 露出** していた。
- v0.31.13 で追加した `_EmissionMap` 関連 (spec entry / TextureKind.ColorEmission / BuildValueXorOverrideEmission1st / `encryptEmissionMap` toggle) を全部 revert し、 v0.31.12 動作 (MainTex / NormalMap / AlphaMask 暗号化) に戻した。
- emission 暗号化は将来 `#ifdef LIL_PASS_FORWARD` 等の pass gate と variant gate を考慮した再設計で再導入予定。

## [0.31.0] — 2026-05-04

### Added

- **Texture Pixel Encryption** (実験的): lilToon material の `_MainTex` / `_BumpMap` (NormalMap) / `_AlphaMask` を CPU XOR PRNG (LCG) ストリーム暗号化。 抽出 PNG が完全 noise になり、 復元には injected shader 一式が必要。 (`_Main2ndTex` は次バージョン予定)
- Multi-material renderer 用 asset-only path: visible texture lock は無いが asset 暗号化は universal に効く
- 圧縮形式 enum (`BC7` / `BC3` / `BC1` / `ETC2_RGBA` / `ASTC_4x4` / `Uncompressed`) を Inspector dropdown で選択可能
- XOR Sort + Mapping Mode (推奨): TiledRaster + Morton 3D sort で BC7 ε を構造的に最小化
- 独立 texture decode key `_AR_TK0..3` (vertex decode `_AR_K0..3` と分離して SMR/MR 共通動作)
- `Window/紫陽花広場/Anti-Ripping/Setting` メニューを追加 (window を明示的に開く専用エントリ)
- AntiRippingWindow 上部に banner、 下部に BOOTH / Discord / Ko-fi リンク + 紫陽花広場 Works ブランド + version footer

### Changed

- Step 3 Inspector UI を 3 カテゴリに再編:
  - 🛡 **視覚保護** (オレンジ強調、 暖色 tint card): 見た目に直接影響する Mesh Lock + Shader 復号 + テクスチャ暗号化
  - 📋 **流出追跡** (青): 鍵不要、 アセット透かし + Hierarchy 透かし + lilToon 保護 + Build Fingerprint
  - 🎭 **識別防止難読化** (緑): 動作不変、 GameObject / BlendShape / AnimatorController / アセット名 + Decoy + Shuffle
- テクスチャ暗号化の advanced 項目 (解像度・圧縮形式・モード) を foldout に格納してデフォルト UI を簡潔化
- Banner / Footer 共有 helper class (`AntiRippingBranding`) を Inspector / Window 両方で利用

### Fixed

- multi-material asset-only path で K も bake すると元 mesh の UV6/7 で予期せぬ vertex displacement → mesh 復元失敗 (K=0 維持で解決)
- GPU sampler vs shader cast の精度差で texel 境界 1 texel ずれ → skin texture に horizontal banding (波模様) → UV を texel center に snap (`(floor(uv*size)+0.5)/size`) で解決
- 暗号化 asset 名露出 (`UV1_Base 1_AREnc_MainTex` 等) → `_<16hex>` random 生成で解決
- LilToonShaderInjector cache hash に injection 内容を含めて stale cache 防止

### Compatibility

- Unity 2022.3+
- Required: NDMF 1.4.0+ / Modular Avatar 1.10.0+
- Recommended: lilToon (texture encryption は lilToon 限定)、 Poiyomi (shader-level decode 対応)
