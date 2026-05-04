# Changelog — Anti-Ripping

All notable changes to this VPM package.

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
