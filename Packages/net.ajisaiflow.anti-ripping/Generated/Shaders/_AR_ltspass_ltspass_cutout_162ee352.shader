Shader "Hidden/ltspass_arlocked_ltspass_cutout_162ee352"
{
    Properties
    {
        // ── AjisaiAR injection (v0.12: vertex displacement keys) ──
        _AR_K0 ("AR Key 0", Float) = 0
        _AR_K1 ("AR Key 1", Float) = 0
        _AR_K2 ("AR Key 2", Float) = 0
        _AR_K3 ("AR Key 3", Float) = 0
        // ── AjisaiAR injection (v0.31: texture decode keys) ──
        // vertex decode K (= _AR_K0..3) は SMR で 0 に固定される (BlendShape との二重 decode 防止)。
        // texture decode は shader 経路のみのため SMR でも bakeKey を受け取る独立 parameter が必要。
        // ShaderLockPass が AAP layer で SMR/MR 共通に bakeKey を driving する。
        _AR_TK0 ("AR Texture Key 0", Float) = 0
        _AR_TK1 ("AR Texture Key 1", Float) = 0
        _AR_TK2 ("AR Texture Key 2", Float) = 0
        _AR_TK3 ("AR Texture Key 3", Float) = 0
        // ── AjisaiAR injection (v0.31.x: per-spec texture pixel encryption seeds + mapping) ──
        // 値が 0 のときは shader 内 gate で decode を skip する (= 暗号化されていない material)
        _AR_MainTexSeedLo ("AR MainTex Seed Lo", Float) = 0
        _AR_MainTexSeedHi ("AR MainTex Seed Hi", Float) = 0
        [HideInInspector] _AR_MainTexMapping ("AR MainTex Mapping", 2D) = "white" {}
        _AR_BumpMapSeedLo ("AR BumpMap Seed Lo", Float) = 0
        _AR_BumpMapSeedHi ("AR BumpMap Seed Hi", Float) = 0
        _AR_AlphaMaskSeedLo ("AR AlphaMask Seed Lo", Float) = 0
        _AR_AlphaMaskSeedHi ("AR AlphaMask Seed Hi", Float) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Dummy
        _DummyProperty ("If you are seeing this, some script is broken.", Float) = 0
        _DummyProperty ("This also happens if something other than lilToon is broken.", Float) = 0
        _DummyProperty ("You need to check the error on the console and take appropriate action, such as reinstalling the relevant tool.", Float) = 0
        _DummyProperty (" ", Float) = 0
        _DummyProperty ("これが表示されている場合、なんらかのスクリプトが壊れています。", Float) = 0
        _DummyProperty ("これはlilToon以外のものが壊れている場合にも発生します。", Float) = 0
        _DummyProperty ("コンソールでエラーを確認し、該当するツールを入れ直すなどの対処を行う必要があります。", Float) = 0
        [Space(1000)]
        _DummyProperty ("", Float) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Base
        [lilToggle]     _Invisible                  ("sInvisible", Int) = 0
                        _AsUnlit                    ("sAsUnlit", Range(0, 1)) = 0
                        _Cutoff                     ("sCutoff", Range(-0.001,1.001)) = 0.5
                        _SubpassCutoff              ("sSubpassCutoff", Range(0,1)) = 0.5
        [lilToggle]     _FlipNormal                 ("sFlipBackfaceNormal", Int) = 0
        [lilToggle]     _ShiftBackfaceUV            ("sShiftBackfaceUV", Int) = 0
                        _BackfaceForceShadow        ("sBackfaceForceShadow", Range(0,1)) = 0
        [lilHDR]        _BackfaceColor              ("sColor", Color) = (0,0,0,0)
                        _VertexLightStrength        ("sVertexLightStrength", Range(0,1)) = 0
                        _LightMinLimit              ("sLightMinLimit", Range(0,1)) = 0.05
                        _LightMaxLimit              ("sLightMaxLimit", Range(0,10)) = 1
                        _BeforeExposureLimit        ("sBeforeExposureLimit", Float) = 10000
                        _MonochromeLighting         ("sMonochromeLighting", Range(0,1)) = 0
                        _AlphaBoostFA               ("sAlphaBoostFA", Range(1,100)) = 10
                        _lilDirectionalLightStrength ("sDirectionalLightStrength", Range(0,1)) = 1
        [lilVec3B]      _LightDirectionOverride     ("sLightDirectionOverrides", Vector) = (0.001,0.002,0.001,0)
                        _AAStrength                 ("sAAShading", Range(0, 1)) = 1
        [lilToggle]     _UseDither                  ("sDither", Int) = 0
        [NoScaleOffset] _DitherTex                  ("Dither", 2D) = "white" {}
                        _DitherMaxValue             ("Max Value", Float) = 255
                        _EnvRimBorder               ("[VRCLV] Rim Border", Range(0, 3)) = 3.0
                        _EnvRimBlur                 ("[VRCLV] Rim Blur", Range(0, 1)) = 0.35

        //----------------------------------------------------------------------------------------------------------------------
        // Main
        [lilHDR] [MainColor] _Color                 ("sColor", Color) = (1,1,1,1)
        [MainTexture]   _MainTex                    ("Texture", 2D) = "white" {}
        [lilUVAnim]     _MainTex_ScrollRotate       ("sScrollRotates", Vector) = (0,0,0,0)
        [lilHSVG]       _MainTexHSVG                ("sHSVGs", Vector) = (0,1,1,1)
                        _MainGradationStrength      ("Gradation Strength", Range(0, 1)) = 0
        [NoScaleOffset] _MainGradationTex           ("Gradation Map", 2D) = "white" {}
        [NoScaleOffset] _MainColorAdjustMask        ("Adjust Mask", 2D) = "white" {}

        //----------------------------------------------------------------------------------------------------------------------
        // Main2nd
        [lilToggleLeft] _UseMain2ndTex              ("sMainColor2nd", Int) = 0
        [lilHDR]        _Color2nd                   ("sColor", Color) = (1,1,1,1)
                        _Main2ndTex                 ("Texture", 2D) = "white" {}
        [lilAngle]      _Main2ndTexAngle            ("sAngle", Float) = 0
        [lilUVAnim]     _Main2ndTex_ScrollRotate    ("sScrollRotates", Vector) = (0,0,0,0)
        [lilEnum]       _Main2ndTex_UVMode          ("UV Mode|UV0|UV1|UV2|UV3|MatCap", Int) = 0
        [lilEnum]       _Main2ndTex_Cull            ("sCullModes", Int) = 0
        [lilDecalAnim]  _Main2ndTexDecalAnimation   ("sDecalAnimations", Vector) = (1,1,1,30)
        [lilDecalSub]   _Main2ndTexDecalSubParam    ("sDecalSubParams", Vector) = (1,1,0,1)
        [lilToggle]     _Main2ndTexIsDecal          ("sAsDecal", Int) = 0
        [lilToggle]     _Main2ndTexIsLeftOnly       ("Left Only", Int) = 0
        [lilToggle]     _Main2ndTexIsRightOnly      ("Right Only", Int) = 0
        [lilToggle]     _Main2ndTexShouldCopy       ("Copy", Int) = 0
        [lilToggle]     _Main2ndTexShouldFlipMirror ("Flip Mirror", Int) = 0
        [lilToggle]     _Main2ndTexShouldFlipCopy   ("Flip Copy", Int) = 0
        [lilToggle]     _Main2ndTexIsMSDF           ("sAsMSDF", Int) = 0
        [NoScaleOffset] _Main2ndBlendMask           ("Mask", 2D) = "white" {}
        [lilEnum]       _Main2ndTexBlendMode        ("sBlendModes", Int) = 0
        [lilEnum]       _Main2ndTexAlphaMode        ("sAlphaModes", Int) = 0
                        _Main2ndEnableLighting      ("sEnableLighting", Range(0, 1)) = 1
                        _Main2ndDissolveMask        ("Dissolve Mask", 2D) = "white" {}
                        _Main2ndDissolveNoiseMask   ("Dissolve Noise Mask", 2D) = "gray" {}
        [lilUVAnim]     _Main2ndDissolveNoiseMask_ScrollRotate ("Scroll", Vector) = (0,0,0,0)
                        _Main2ndDissolveNoiseStrength ("Dissolve Noise Strength", float) = 0.1
        [lilHDR]        _Main2ndDissolveColor       ("sColor", Color) = (1,1,1,1)
        [lilDissolve]   _Main2ndDissolveParams      ("sDissolveParams", Vector) = (0,0,0.5,0.1)
        [lilDissolveP]  _Main2ndDissolvePos         ("Dissolve Position", Vector) = (0,0,0,0)
        [lilFFFB]       _Main2ndDistanceFade        ("sDistanceFadeSettings", Vector) = (0.1,0.01,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Main3rd
        [lilToggleLeft] _UseMain3rdTex              ("sMainColor3rd", Int) = 0
        [lilHDR]        _Color3rd                   ("sColor", Color) = (1,1,1,1)
                        _Main3rdTex                 ("Texture", 2D) = "white" {}
        [lilAngle]      _Main3rdTexAngle            ("sAngle", Float) = 0
        [lilUVAnim]     _Main3rdTex_ScrollRotate    ("sScrollRotates", Vector) = (0,0,0,0)
        [lilEnum]       _Main3rdTex_UVMode          ("UV Mode|UV0|UV1|UV2|UV3|MatCap", Int) = 0
        [lilEnum]       _Main3rdTex_Cull            ("sCullModes", Int) = 0
        [lilDecalAnim]  _Main3rdTexDecalAnimation   ("sDecalAnimations", Vector) = (1,1,1,30)
        [lilDecalSub]   _Main3rdTexDecalSubParam    ("sDecalSubParams", Vector) = (1,1,0,1)
        [lilToggle]     _Main3rdTexIsDecal          ("sAsDecal", Int) = 0
        [lilToggle]     _Main3rdTexIsLeftOnly       ("Left Only", Int) = 0
        [lilToggle]     _Main3rdTexIsRightOnly      ("Right Only", Int) = 0
        [lilToggle]     _Main3rdTexShouldCopy       ("Copy", Int) = 0
        [lilToggle]     _Main3rdTexShouldFlipMirror ("Flip Mirror", Int) = 0
        [lilToggle]     _Main3rdTexShouldFlipCopy   ("Flip Copy", Int) = 0
        [lilToggle]     _Main3rdTexIsMSDF           ("sAsMSDF", Int) = 0
        [NoScaleOffset] _Main3rdBlendMask           ("Mask", 2D) = "white" {}
        [lilEnum]       _Main3rdTexBlendMode        ("sBlendModes", Int) = 0
        [lilEnum]       _Main3rdTexAlphaMode        ("sAlphaModes", Int) = 0
                        _Main3rdEnableLighting      ("sEnableLighting", Range(0, 1)) = 1
                        _Main3rdDissolveMask        ("Dissolve Mask", 2D) = "white" {}
                        _Main3rdDissolveNoiseMask   ("Dissolve Noise Mask", 2D) = "gray" {}
        [lilUVAnim]     _Main3rdDissolveNoiseMask_ScrollRotate ("Scroll", Vector) = (0,0,0,0)
                        _Main3rdDissolveNoiseStrength ("Dissolve Noise Strength", float) = 0.1
        [lilHDR]        _Main3rdDissolveColor       ("sColor", Color) = (1,1,1,1)
        [lilDissolve]   _Main3rdDissolveParams      ("sDissolveParams", Vector) = (0,0,0.5,0.1)
        [lilDissolveP]  _Main3rdDissolvePos         ("Dissolve Position", Vector) = (0,0,0,0)
        [lilFFFB]       _Main3rdDistanceFade        ("sDistanceFadeSettings", Vector) = (0.1,0.01,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Alpha Mask
        [lilEnumLabel]  _AlphaMaskMode              ("sAlphaMaskModes", Int) = 0
                        _AlphaMask                  ("AlphaMask", 2D) = "white" {}
                        _AlphaMaskScale             ("Scale", Float) = 1
                        _AlphaMaskValue             ("Offset", Float) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // NormalMap
        [lilToggleLeft] _UseBumpMap                 ("sNormalMap", Int) = 0
        [Normal]        _BumpMap                    ("Normal Map", 2D) = "bump" {}
                        _BumpScale                  ("Scale", Range(-10,10)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // NormalMap 2nd
        [lilToggleLeft] _UseBump2ndMap              ("sNormalMap2nd", Int) = 0
        [Normal]        _Bump2ndMap                 ("Normal Map", 2D) = "bump" {}
        [lilEnum]       _Bump2ndMap_UVMode          ("UV Mode|UV0|UV1|UV2|UV3", Int) = 0
                        _Bump2ndScale               ("Scale", Range(-10,10)) = 1
        [NoScaleOffset] _Bump2ndScaleMask           ("Mask", 2D) = "white" {}

        //----------------------------------------------------------------------------------------------------------------------
        // Anisotropy
        [lilToggleLeft] _UseAnisotropy              ("sAnisotropy", Int) = 0
        [Normal]        _AnisotropyTangentMap       ("Tangent Map", 2D) = "bump" {}
                        _AnisotropyScale            ("Scale", Range(-1,1)) = 1
        [NoScaleOffset] _AnisotropyScaleMask        ("Scale Mask", 2D) = "white" {}
                        _AnisotropyTangentWidth     ("sTangentWidth", Range(0,10)) = 1
                        _AnisotropyBitangentWidth   ("sBitangentWidth", Range(0,10)) = 1
                        _AnisotropyShift            ("sOffset", Range(-10,10)) = 0
                        _AnisotropyShiftNoiseScale  ("sNoiseStrength", Range(-1,1)) = 0
                        _AnisotropySpecularStrength ("sStrength", Range(0,10)) = 1
                        _Anisotropy2ndTangentWidth  ("sTangentWidth", Range(0,10)) = 1
                        _Anisotropy2ndBitangentWidth ("sBitangentWidth", Range(0,10)) = 1
                        _Anisotropy2ndShift         ("sOffset", Range(-10,10)) = 0
                        _Anisotropy2ndShiftNoiseScale ("sNoiseStrength", Range(-1,1)) = 0
                        _Anisotropy2ndSpecularStrength ("sStrength", Range(0,10)) = 0
                        _AnisotropyShiftNoiseMask   ("sNoise", 2D) = "white" {}
        [lilToggle]     _Anisotropy2Reflection      ("sReflection", Int) = 0
        [lilToggle]     _Anisotropy2MatCap          ("sMatCap", Int) = 0
        [lilToggle]     _Anisotropy2MatCap2nd       ("sMatCap2nd", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Backlight
        [lilToggleLeft] _UseBacklight               ("sBacklight", Int) = 0
        [lilHDR]        _BacklightColor             ("sColor", Color) = (0.85,0.8,0.7,1.0)
        [NoScaleOffset] _BacklightColorTex          ("Texture", 2D) = "white" {}
                        _BacklightMainStrength      ("sMainColorPower", Range(0, 1)) = 0
                        _BacklightNormalStrength    ("sNormalStrength", Range(0, 1)) = 1.0
                        _BacklightBorder            ("Border", Range(0, 1)) = 0.35
                        _BacklightBlur              ("sBlur", Range(0, 1)) = 0.05
                        _BacklightDirectivity       ("sDirectivity", Float) = 5.0
                        _BacklightViewStrength      ("sViewDirectionStrength", Range(0, 1)) = 1
        [lilToggle]     _BacklightReceiveShadow     ("sReceiveShadow", Int) = 1
        [lilToggle]     _BacklightBackfaceMask      ("sBackfaceMask", Int) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Shadow
        [lilToggleLeft] _UseShadow                  ("sShadow", Int) = 0
                        _ShadowStrength             ("sStrength", Range(0, 1)) = 1
        [NoScaleOffset] _ShadowStrengthMask         ("sStrength", 2D) = "white" {}
        [lilLOD]        _ShadowStrengthMaskLOD      ("LOD", Range(0, 1)) = 0
        [NoScaleOffset] _ShadowBorderMask           ("sBorder", 2D) = "white" {}
        [lilLOD]        _ShadowBorderMaskLOD        ("LOD", Range(0, 1)) = 0
        [NoScaleOffset] _ShadowBlurMask             ("sBlur", 2D) = "white" {}
        [lilLOD]        _ShadowBlurMaskLOD          ("LOD", Range(0, 1)) = 0
        [lilFFFF]       _ShadowAOShift              ("1st Scale|1st Offset|2nd Scale|2nd Offset", Vector) = (1,0,1,0)
        [lilFF]         _ShadowAOShift2             ("3rd Scale|3rd Offset", Vector) = (1,0,1,0)
        [lilToggle]     _ShadowPostAO               ("sIgnoreBorderProperties", Int) = 0
        [lilEnum]       _ShadowColorType            ("sShadowColorTypes", Int) = 0
                        _ShadowColor                ("Shadow Color", Color) = (0.82,0.76,0.85,1.0)
        [NoScaleOffset] _ShadowColorTex             ("Shadow Color", 2D) = "black" {}
                        _ShadowNormalStrength       ("sNormalStrength", Range(0, 1)) = 1.0
                        _ShadowBorder               ("sBorder", Range(0, 1)) = 0.5
                        _ShadowBlur                 ("sBlur", Range(0, 1)) = 0.1
                        _ShadowReceive              ("sReceiveShadow", Range(0, 1)) = 0
                        _Shadow2ndColor             ("2nd Color", Color) = (0.68,0.66,0.79,1)
        [NoScaleOffset] _Shadow2ndColorTex          ("2nd Color", 2D) = "black" {}
                        _Shadow2ndNormalStrength    ("sNormalStrength", Range(0, 1)) = 1.0
                        _Shadow2ndBorder            ("sBorder", Range(0, 1)) = 0.15
                        _Shadow2ndBlur              ("sBlur", Range(0, 1)) = 0.1
                        _Shadow2ndReceive           ("sReceiveShadow", Range(0, 1)) = 0
                        _Shadow3rdColor             ("3rd Color", Color) = (0,0,0,0)
        [NoScaleOffset] _Shadow3rdColorTex          ("3rd Color", 2D) = "black" {}
                        _Shadow3rdNormalStrength    ("sNormalStrength", Range(0, 1)) = 1.0
                        _Shadow3rdBorder            ("sBorder", Range(0, 1)) = 0.25
                        _Shadow3rdBlur              ("sBlur", Range(0, 1)) = 0.1
                        _Shadow3rdReceive           ("sReceiveShadow", Range(0, 1)) = 0
                        _ShadowBorderColor          ("sShadowBorderColor", Color) = (1,0.1,0,1)
                        _ShadowBorderRange          ("sShadowBorderRange", Range(0, 1)) = 0.08
                        _ShadowMainStrength         ("sContrast", Range(0, 1)) = 0
                        _ShadowEnvStrength          ("sShadowEnvStrength", Range(0, 1)) = 0
        [lilEnum]       _ShadowMaskType             ("sShadowMaskTypes", Int) = 0
                        _ShadowFlatBorder           ("sBorder", Range(-2, 2)) = 1
                        _ShadowFlatBlur             ("sBlur", Range(0.001, 2)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Rim Shade
        [lilToggleLeft] _UseRimShade                ("RimShade", Int) = 0
                        _RimShadeColor              ("sColor", Color) = (0.5,0.5,0.5,1.0)
        [NoScaleOffset] _RimShadeMask               ("Mask", 2D) = "white" {}
                        _RimShadeNormalStrength     ("sNormalStrength", Range(0, 1)) = 1.0
                        _RimShadeBorder             ("sBorder", Range(0, 1)) = 0.5
                        _RimShadeBlur               ("sBlur", Range(0, 1)) = 1.0
        [PowerSlider(3.0)]_RimShadeFresnelPower     ("sFresnelPower", Range(0.01, 50)) = 1.0

        //----------------------------------------------------------------------------------------------------------------------
        // Reflection
        [lilToggleLeft] _UseReflection              ("sReflection", Int) = 0
        // Smoothness
                        _Smoothness                 ("Smoothness", Range(0, 1)) = 1
        [NoScaleOffset] _SmoothnessTex              ("Smoothness", 2D) = "white" {}
        // Metallic
        [Gamma]         _Metallic                   ("Metallic", Range(0, 1)) = 0
        [NoScaleOffset] _MetallicGlossMap           ("Metallic", 2D) = "white" {}
        // Reflectance
        [Gamma]         _Reflectance                ("sReflectance", Range(0, 1)) = 0.04
        // Reflection
                        _GSAAStrength               ("GSAA", Range(0, 1)) = 0
        [lilToggle]     _ApplySpecular              ("Apply Specular", Int) = 1
        [lilToggle]     _ApplySpecularFA            ("sMultiLightSpecular", Int) = 1
        [lilToggle]     _SpecularToon               ("Specular Toon", Int) = 1
                        _SpecularNormalStrength     ("sNormalStrength", Range(0, 1)) = 1.0
                        _SpecularBorder             ("sBorder", Range(0, 1)) = 0.5
                        _SpecularBlur               ("sBlur", Range(0, 1)) = 0.0
        [lilToggle]     _ApplyReflection            ("sApplyReflection", Int) = 0
                        _ReflectionNormalStrength   ("sNormalStrength", Range(0, 1)) = 1.0
        [lilHDR]        _ReflectionColor            ("sColor", Color) = (1,1,1,1)
        [NoScaleOffset] _ReflectionColorTex         ("sColor", 2D) = "white" {}
        [lilToggle]     _ReflectionApplyTransparency ("sApplyTransparency", Int) = 1
        [NoScaleOffset] _ReflectionCubeTex          ("Cubemap Fallback", Cube) = "black" {}
        [lilHDR]        _ReflectionCubeColor        ("sColor", Color) = (0,0,0,1)
        [lilToggle]     _ReflectionCubeOverride     ("Override", Int) = 0
                        _ReflectionCubeEnableLighting ("sEnableLighting+ (Fallback)", Range(0, 1)) = 1
        [lilEnum]       _ReflectionBlendMode        ("sBlendModes", Int) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // MatCap
        [lilToggleLeft] _UseMatCap                  ("sMatCap", Int) = 0
        [lilHDR]        _MatCapColor                ("sColor", Color) = (1,1,1,1)
                        _MatCapTex                  ("Texture", 2D) = "white" {}
                        _MatCapMainStrength         ("sMainColorPower", Range(0, 1)) = 0
        [lilVec2R]      _MatCapBlendUV1             ("sBlendUV1", Vector) = (0,0,0,0)
        [lilToggle]     _MatCapZRotCancel           ("sMatCapZRotCancel", Int) = 1
        [lilToggle]     _MatCapPerspective          ("sFixPerspective", Int) = 1
                        _MatCapVRParallaxStrength   ("sVRParallaxStrength", Range(0, 1)) = 1
                        _MatCapBlend                ("Blend", Range(0, 1)) = 1
        [NoScaleOffset] _MatCapBlendMask            ("Mask", 2D) = "white" {}
                        _MatCapEnableLighting       ("sEnableLighting", Range(0, 1)) = 1
                        _MatCapShadowMask           ("sShadowMask", Range(0, 1)) = 0
        [lilToggle]     _MatCapBackfaceMask         ("sBackfaceMask", Int) = 0
                        _MatCapLod                  ("sBlur", Range(0, 10)) = 0
        [lilEnum]       _MatCapBlendMode            ("sBlendModes", Int) = 1
        [lilToggle]     _MatCapApplyTransparency    ("sApplyTransparency", Int) = 1
                        _MatCapNormalStrength       ("sNormalStrength", Range(0, 1)) = 1.0
        [lilToggle]     _MatCapCustomNormal         ("sMatCapCustomNormal", Int) = 0
        [Normal]        _MatCapBumpMap              ("Normal Map", 2D) = "bump" {}
                        _MatCapBumpScale            ("Scale", Range(-10,10)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // MatCap 2nd
        [lilToggleLeft] _UseMatCap2nd               ("sMatCap2nd", Int) = 0
        [lilHDR]        _MatCap2ndColor             ("sColor", Color) = (1,1,1,1)
                        _MatCap2ndTex               ("Texture", 2D) = "white" {}
                        _MatCap2ndMainStrength      ("sMainColorPower", Range(0, 1)) = 0
        [lilVec2R]      _MatCap2ndBlendUV1          ("sBlendUV1", Vector) = (0,0,0,0)
        [lilToggle]     _MatCap2ndZRotCancel        ("sMatCapZRotCancel", Int) = 1
        [lilToggle]     _MatCap2ndPerspective       ("sFixPerspective", Int) = 1
                        _MatCap2ndVRParallaxStrength ("sVRParallaxStrength", Range(0, 1)) = 1
                        _MatCap2ndBlend             ("Blend", Range(0, 1)) = 1
        [NoScaleOffset] _MatCap2ndBlendMask         ("Mask", 2D) = "white" {}
                        _MatCap2ndEnableLighting    ("sEnableLighting", Range(0, 1)) = 1
                        _MatCap2ndShadowMask        ("sShadowMask", Range(0, 1)) = 0
        [lilToggle]     _MatCap2ndBackfaceMask      ("sBackfaceMask", Int) = 0
                        _MatCap2ndLod               ("sBlur", Range(0, 10)) = 0
        [lilEnum]       _MatCap2ndBlendMode         ("sBlendModes", Int) = 1
        [lilToggle]     _MatCap2ndApplyTransparency ("sApplyTransparency", Int) = 1
                        _MatCap2ndNormalStrength    ("sNormalStrength", Range(0, 1)) = 1.0
        [lilToggle]     _MatCap2ndCustomNormal      ("sMatCapCustomNormal", Int) = 0
        [Normal]        _MatCap2ndBumpMap           ("Normal Map", 2D) = "bump" {}
                        _MatCap2ndBumpScale         ("Scale", Range(-10,10)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Rim
        [lilToggleLeft] _UseRim                     ("sRimLight", Int) = 0
        [lilHDR]        _RimColor                   ("sColor", Color) = (0.66,0.5,0.48,1)
        [NoScaleOffset] _RimColorTex                ("Texture", 2D) = "white" {}
                        _RimMainStrength            ("sMainColorPower", Range(0, 1)) = 0
                        _RimNormalStrength          ("sNormalStrength", Range(0, 1)) = 1.0
                        _RimBorder                  ("sBorder", Range(0, 1)) = 0.5
                        _RimBlur                    ("sBlur", Range(0, 1)) = 0.65
        [PowerSlider(3.0)]_RimFresnelPower          ("sFresnelPower", Range(0.01, 50)) = 3.5
                        _RimEnableLighting          ("sEnableLighting", Range(0, 1)) = 1
                        _RimShadowMask              ("sShadowMask", Range(0, 1)) = 0.5
        [lilToggle]     _RimBackfaceMask            ("sBackfaceMask", Int) = 1
                        _RimVRParallaxStrength      ("sVRParallaxStrength", Range(0, 1)) = 1
        [lilToggle]     _RimApplyTransparency       ("sApplyTransparency", Int) = 1
                        _RimDirStrength             ("sRimLightDirection", Range(0, 1)) = 0
                        _RimDirRange                ("sRimDirectionRange", Range(-1, 1)) = 0
                        _RimIndirRange              ("sRimIndirectionRange", Range(-1, 1)) = 0
        [lilHDR]        _RimIndirColor              ("sColor", Color) = (1,1,1,1)
                        _RimIndirBorder             ("sBorder", Range(0, 1)) = 0.5
                        _RimIndirBlur               ("sBlur", Range(0, 1)) = 0.1
        [lilEnum]       _RimBlendMode               ("sBlendModes", Int) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Glitter
        [lilToggleLeft] _UseGlitter                 ("sGlitter", Int) = 0
        [lilEnum]       _GlitterUVMode              ("UV Mode|UV0|UV1", Int) = 0
        [lilHDR]        _GlitterColor               ("sColor", Color) = (1,1,1,1)
                        _GlitterColorTex            ("Texture", 2D) = "white" {}
        [lilEnum]       _GlitterColorTex_UVMode     ("UV Mode|UV0|UV1|UV2|UV3", Int) = 0
                        _GlitterMainStrength        ("sMainColorPower", Range(0, 1)) = 0
                        _GlitterNormalStrength      ("sNormalStrength", Range(0, 1)) = 1.0
                        _GlitterScaleRandomize      ("sRandomize+ (Size)", Range(0, 1)) = 0
        [lilToggle]     _GlitterApplyShape          ("Shape", Int) = 0
                        _GlitterShapeTex            ("Texture", 2D) = "white" {}
        [lilVec2]       _GlitterAtras               ("Atras", Vector) = (1,1,0,0)
        [lilToggle]     _GlitterAngleRandomize      ("sRandomize+ (+sAngle+)", Int) = 0
        [lilGlitParam1] _GlitterParams1             ("Tiling|Particle Size|Contrast", Vector) = (256,256,0.16,50)
        [lilGlitParam2] _GlitterParams2             ("sGlitterParams2", Vector) = (0.25,0,0,0)
                        _GlitterPostContrast        ("sPostContrast", Float) = 1
                        _GlitterSensitivity         ("Sensitivity", Float) = 0.25
                        _GlitterEnableLighting      ("sEnableLighting", Range(0, 1)) = 1
                        _GlitterShadowMask          ("sShadowMask", Range(0, 1)) = 0
        [lilToggle]     _GlitterBackfaceMask        ("sBackfaceMask", Int) = 0
        [lilToggle]     _GlitterApplyTransparency   ("sApplyTransparency", Int) = 1
                        _GlitterVRParallaxStrength  ("sVRParallaxStrength", Range(0, 1)) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Emmision
        [lilToggleLeft] _UseEmission                ("sEmission", Int) = 0
        [HDR][lilHDR]   _EmissionColor              ("sColor", Color) = (1,1,1,1)
                        _EmissionMap                ("Texture", 2D) = "white" {}
        [lilUVAnim]     _EmissionMap_ScrollRotate   ("sScrollRotates", Vector) = (0,0,0,0)
        [lilEnum]       _EmissionMap_UVMode         ("UV Mode|UV0|UV1|UV2|UV3|Rim", Int) = 0
                        _EmissionMainStrength       ("sMainColorPower", Range(0, 1)) = 0
                        _EmissionBlend              ("Blend", Range(0,1)) = 1
                        _EmissionBlendMask          ("Mask", 2D) = "white" {}
        [lilUVAnim]     _EmissionBlendMask_ScrollRotate ("sScrollRotates", Vector) = (0,0,0,0)
        [lilEnum]       _EmissionBlendMode          ("sBlendModes", Int) = 1
        [lilBlink]      _EmissionBlink              ("sBlinkSettings", Vector) = (0,0,3.141593,0)
        [lilToggle]     _EmissionUseGrad            ("sGradation", Int) = 0
        [NoScaleOffset] _EmissionGradTex            ("Gradation Texture", 2D) = "white" {}
                        _EmissionGradSpeed          ("Gradation Speed", Float) = 1
                        _EmissionParallaxDepth      ("sParallaxDepth", float) = 0
                        _EmissionFluorescence       ("sFluorescence", Range(0,1)) = 0
        // Gradation
        [HideInInspector] _egci ("", Int) = 2
        [HideInInspector] _egai ("", Int) = 2
        [HideInInspector] _egc0 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc1 ("", Color) = (1,1,1,1)
        [HideInInspector] _egc2 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc3 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc4 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc5 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc6 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc7 ("", Color) = (1,1,1,0)
        [HideInInspector] _ega0 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega1 ("", Color) = (1,0,0,1)
        [HideInInspector] _ega2 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega3 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega4 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega5 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega6 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega7 ("", Color) = (1,0,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Emmision2nd
        [lilToggleLeft] _UseEmission2nd             ("sEmission2nd", Int) = 0
        [HDR][lilHDR]   _Emission2ndColor           ("sColor", Color) = (1,1,1,1)
                        _Emission2ndMap             ("Texture", 2D) = "white" {}
        [lilUVAnim]     _Emission2ndMap_ScrollRotate ("sScrollRotates", Vector) = (0,0,0,0)
        [lilEnum]       _Emission2ndMap_UVMode      ("UV Mode|UV0|UV1|UV2|UV3|Rim", Int) = 0
                        _Emission2ndMainStrength    ("sMainColorPower", Range(0, 1)) = 0
                        _Emission2ndBlend           ("Blend", Range(0,1)) = 1
                        _Emission2ndBlendMask       ("Mask", 2D) = "white" {}
        [lilUVAnim]     _Emission2ndBlendMask_ScrollRotate ("sScrollRotates", Vector) = (0,0,0,0)
        [lilEnum]       _Emission2ndBlendMode       ("sBlendModes", Int) = 1
        [lilBlink]      _Emission2ndBlink           ("sBlinkSettings", Vector) = (0,0,3.141593,0)
        [lilToggle]     _Emission2ndUseGrad         ("sGradation", Int) = 0
        [NoScaleOffset] _Emission2ndGradTex         ("Gradation Texture", 2D) = "white" {}
                        _Emission2ndGradSpeed       ("Gradation Speed", Float) = 1
                        _Emission2ndParallaxDepth   ("sParallaxDepth", float) = 0
                        _Emission2ndFluorescence    ("sFluorescence", Range(0,1)) = 0
        // Gradation
        [HideInInspector] _e2gci ("", Int) = 2
        [HideInInspector] _e2gai ("", Int) = 2
        [HideInInspector] _e2gc0 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc1 ("", Color) = (1,1,1,1)
        [HideInInspector] _e2gc2 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc3 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc4 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc5 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc6 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc7 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2ga0 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga1 ("", Color) = (1,0,0,1)
        [HideInInspector] _e2ga2 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga3 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga4 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga5 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga6 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga7 ("", Color) = (1,0,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Parallax
        [lilToggleLeft] _UseParallax                ("sParallax", Int) = 0
        [lilToggle]     _UsePOM                     ("sPOM", Int) = 0
        [NoScaleOffset] _ParallaxMap                ("Parallax Map", 2D) = "gray" {}
                        _Parallax                   ("Parallax Scale", float) = 0.02
                        _ParallaxOffset             ("sParallaxOffset", float) = 0.5

        //----------------------------------------------------------------------------------------------------------------------
        // Distance Fade
        [lilHDR]        _DistanceFadeColor          ("sColor", Color) = (0,0,0,1)
        [lilFFFB]       _DistanceFade               ("sDistanceFadeSettings", Vector) = (0.1,0.01,0,0)
        [lilEnum]       _DistanceFadeMode           ("sDistanceFadeModes", Int) = 0
        [lilHDR]        _DistanceFadeRimColor       ("sColor", Color) = (0,0,0,0)
        [PowerSlider(3.0)]_DistanceFadeRimFresnelPower ("sFresnelPower", Range(0.01, 50)) = 5.0

        //----------------------------------------------------------------------------------------------------------------------
        // AudioLink
        [lilToggleLeft] _UseAudioLink               ("sAudioLink", Int) = 0
        [lilFRFR]       _AudioLinkDefaultValue      ("Strength|Blink Strength|Blink Speed|Blink Threshold", Vector) = (0.0,0.0,2.0,0.75)
        [lilEnum]       _AudioLinkUVMode            ("sAudioLinkUVModes", Int) = 1
        [lilALUVParams] _AudioLinkUVParams          ("Scale|Offset|sAngle|Band|Bass|Low Mid|High Mid|Treble", Vector) = (0.25,0,0,0.125)
        [lilVec3]       _AudioLinkStart             ("sAudioLinkStartPosition", Vector) = (0.0,0.0,0.0,0.0)
                        _AudioLinkMask              ("Mask", 2D) = "blue" {}
        [lilUVAnim]     _AudioLinkMask_ScrollRotate ("sScrollRotates", Vector) = (0,0,0,0)
        [lilEnum]       _AudioLinkMask_UVMode       ("UV Mode|UV0|UV1|UV2|UV3", Int) = 0
        [lilToggle]     _AudioLink2Main2nd          ("sMainColor2nd", Int) = 0
        [lilToggle]     _AudioLink2Main3rd          ("sMainColor3rd", Int) = 0
        [lilToggle]     _AudioLink2Emission         ("sEmission", Int) = 0
        [lilToggle]     _AudioLink2EmissionGrad     ("sEmission+sGradation", Int) = 0
        [lilToggle]     _AudioLink2Emission2nd      ("sEmission2nd", Int) = 0
        [lilToggle]     _AudioLink2Emission2ndGrad  ("sEmission2nd+sGradation", Int) = 0
        [lilToggle]     _AudioLink2Vertex           ("sVertex", Int) = 0
        [lilEnum]       _AudioLinkVertexUVMode      ("sAudioLinkVertexUVModes", Int) = 1
        [lilALUVParams] _AudioLinkVertexUVParams    ("Scale|Offset|sAngle|Band|Bass|Low Mid|High Mid|Treble", Vector) = (0.25,0,0,0.125)
        [lilVec3]       _AudioLinkVertexStart       ("sAudioLinkStartPosition", Vector) = (0.0,0.0,0.0,0.0)
        [lilVec3Float]  _AudioLinkVertexStrength    ("sAudioLinkVertexStrengths", Vector) = (0.0,0.0,0.0,1.0)
        [lilToggle]     _AudioLinkAsLocal           ("sAudioLinkAsLocal", Int) = 0
        [NoScaleOffset] _AudioLinkLocalMap          ("Local Map", 2D) = "black" {}
        [lilALLocal]    _AudioLinkLocalMapParams    ("sAudioLinkLocalMapParams", Vector) = (120,1,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Dissolve
                        _DissolveMask               ("Dissolve Mask", 2D) = "white" {}
                        _DissolveNoiseMask          ("Dissolve Noise Mask", 2D) = "gray" {}
        [lilUVAnim]     _DissolveNoiseMask_ScrollRotate ("Scroll", Vector) = (0,0,0,0)
                        _DissolveNoiseStrength      ("Dissolve Noise Strength", float) = 0.1
        [lilHDR]        _DissolveColor              ("sColor", Color) = (1,1,1,1)
        [lilDissolve]   _DissolveParams             ("sDissolveParamsModes", Vector) = (0,0,0.5,0.1)
        [lilDissolveP]  _DissolvePos                ("Dissolve Position", Vector) = (0,0,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // ID Mask
        // _IDMaskCompile will enable compilation of IDMask-related systems. For compatibility, setting certain
        // parameters to non-zero values will also enable the IDMask feature, but this enable switch ensures that
        // animator-controlled IDMasked meshes will be compiled correctly. Note that this _only_ controls compilation,
        // and is ignored at runtime.
        [ToggleUI]      _IDMaskCompile              ("_IDMaskCompile", Int) = 0
        [lilEnum]       _IDMaskFrom                 ("_IDMaskFrom|0: UV0|1: UV1|2: UV2|3: UV3|4: UV4|5: UV5|6: UV6|7: UV7|8: VertexID", Int) = 8
        [ToggleUI]      _IDMask1                    ("_IDMask1", Int) = 0
        [ToggleUI]      _IDMask2                    ("_IDMask2", Int) = 0
        [ToggleUI]      _IDMask3                    ("_IDMask3", Int) = 0
        [ToggleUI]      _IDMask4                    ("_IDMask4", Int) = 0
        [ToggleUI]      _IDMask5                    ("_IDMask5", Int) = 0
        [ToggleUI]      _IDMask6                    ("_IDMask6", Int) = 0
        [ToggleUI]      _IDMask7                    ("_IDMask7", Int) = 0
        [ToggleUI]      _IDMask8                    ("_IDMask8", Int) = 0
        [ToggleUI]      _IDMaskIsBitmap             ("_IDMaskIsBitmap", Int) = 0
                        _IDMaskIndex1               ("_IDMaskIndex1", Int) = 0
                        _IDMaskIndex2               ("_IDMaskIndex2", Int) = 0
                        _IDMaskIndex3               ("_IDMaskIndex3", Int) = 0
                        _IDMaskIndex4               ("_IDMaskIndex4", Int) = 0
                        _IDMaskIndex5               ("_IDMaskIndex5", Int) = 0
                        _IDMaskIndex6               ("_IDMaskIndex6", Int) = 0
                        _IDMaskIndex7               ("_IDMaskIndex7", Int) = 0
                        _IDMaskIndex8               ("_IDMaskIndex8", Int) = 0

        [ToggleUI]      _IDMaskControlsDissolve     ("_IDMaskControlsDissolve", Int) = 0
        [ToggleUI]      _IDMaskPrior1               ("_IDMaskPrior1", Int) = 0
        [ToggleUI]      _IDMaskPrior2               ("_IDMaskPrior2", Int) = 0
        [ToggleUI]      _IDMaskPrior3               ("_IDMaskPrior3", Int) = 0
        [ToggleUI]      _IDMaskPrior4               ("_IDMaskPrior4", Int) = 0
        [ToggleUI]      _IDMaskPrior5               ("_IDMaskPrior5", Int) = 0
        [ToggleUI]      _IDMaskPrior6               ("_IDMaskPrior6", Int) = 0
        [ToggleUI]      _IDMaskPrior7               ("_IDMaskPrior7", Int) = 0
        [ToggleUI]      _IDMaskPrior8               ("_IDMaskPrior8", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // UDIM Discard
        [lilToggleLeft] _UDIMDiscardCompile         ("sUDIMDiscard", Int) = 0
        [lilEnum]       _UDIMDiscardUV              ("sUDIMDiscardUV|0: UV0|1: UV1|2: UV2|3: UV3", Int) = 0
        [lilEnum]       _UDIMDiscardMode            ("sUDIMDiscardMode|0: Vertex|1: Pixel (slower)", Int) = 0
        [lilToggle]     _UDIMDiscardRow3_3          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow3_2          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow3_1          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow3_0          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow2_3          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow2_2          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow2_1          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow2_0          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow1_3          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow1_2          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow1_1          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow1_0          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow0_3          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow0_2          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow0_1          ("", Int) = 0
        [lilToggle]     _UDIMDiscardRow0_0          ("", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Outline
        [lilHDR]        _OutlineColor               ("sColor", Color) = (0.6,0.56,0.73,1)
                        _OutlineTex                 ("Texture", 2D) = "white" {}
        [lilUVAnim]     _OutlineTex_ScrollRotate    ("sScrollRotates", Vector) = (0,0,0,0)
        [lilHSVG]       _OutlineTexHSVG             ("sHSVGs", Vector) = (0,1,1,1)
        [lilHDR]        _OutlineLitColor            ("sColor", Color) = (1.0,0.2,0,0)
        [lilToggle]     _OutlineLitApplyTex         ("sColorFromMain", Int) = 0
                        _OutlineLitScale            ("Scale", Float) = 10
                        _OutlineLitOffset           ("Offset", Float) = -8
        [lilToggle]     _OutlineLitShadowReceive    ("sReceiveShadow", Int) = 0
        [lilOLWidth]    _OutlineWidth               ("Width", Range(0,1)) = 0.08
        [NoScaleOffset] _OutlineWidthMask           ("Width", 2D) = "white" {}
                        _OutlineFixWidth            ("sFixWidth", Range(0,1)) = 0.5
        [lilEnum]       _OutlineVertexR2Width       ("sOutlineVertexColorUsages", Int) = 0
        [lilToggle]     _OutlineDeleteMesh          ("sDeleteMesh0", Int) = 0
        [NoScaleOffset][Normal] _OutlineVectorTex   ("Vector", 2D) = "bump" {}
        [lilEnum]       _OutlineVectorUVMode        ("UV Mode|UV0|UV1|UV2|UV3", Int) = 0
                        _OutlineVectorScale         ("Vector scale", Range(-10,10)) = 1
                        _OutlineEnableLighting      ("sEnableLighting", Range(0, 1)) = 1
                        _OutlineZBias               ("Z Bias", Float) = 0
        [lilToggle]     _OutlineDisableInVR         ("sDisableInVR", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Tessellation
                        _TessEdge                   ("sTessellationEdge", Range(1, 100)) = 10
                        _TessStrength               ("sStrength", Range(0, 1)) = 0.5
                        _TessShrink                 ("sTessellationShrink", Range(0, 1)) = 0.0
        [IntRange]      _TessFactorMax              ("sTessellationFactor", Range(1, 8)) = 3

        //----------------------------------------------------------------------------------------------------------------------
        // For Multi
        [lilToggleLeft] _UseOutline                 ("Use Outline", Int) = 0
        [lilEnum]       _TransparentMode            ("Rendering Mode|Opaque|Cutout|Transparent|Refraction|Fur|FurCutout|Gem", Int) = 0
        [lilToggle]     _UseClippingCanceller       ("sSettingClippingCanceller", Int) = 0
        [lilToggle]     _AsOverlay                  ("sAsOverlay", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Save (Unused)
        [HideInInspector]                               _BaseColor          ("sColor", Color) = (1,1,1,1)
        [HideInInspector]                               _BaseMap            ("Texture", 2D) = "white" {}
        [HideInInspector]                               _BaseColorMap       ("Texture", 2D) = "white" {}
        [HideInInspector]                               _lilToonVersion     ("Version", Int) = 45

        //----------------------------------------------------------------------------------------------------------------------
        // VRChat
        _Ramp ("Shadow Ramp", 2D) = "white" {}

        //----------------------------------------------------------------------------------------------------------------------
        // Advanced
        [lilEnum]                                       _Cull               ("sCullModes", Int) = 2
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlend           ("sSrcBlendRGB", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlend           ("sDstBlendRGB", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlendAlpha      ("sSrcBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlendAlpha      ("sDstBlendAlpha", Int) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOp            ("sBlendOpRGB", Int) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOpAlpha       ("sBlendOpAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlendFA         ("sSrcBlendRGB", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlendFA         ("sDstBlendRGB", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlendAlphaFA    ("sSrcBlendAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlendAlphaFA    ("sDstBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOpFA          ("sBlendOpRGB", Int) = 4
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOpAlphaFA     ("sBlendOpAlpha", Int) = 4
        [lilToggle]                                     _ZClip              ("sZClip", Int) = 1
        [lilToggle]                                     _ZWrite             ("sZWrite", Int) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]   _ZTest              ("sZTest", Int) = 4
        [IntRange]                                      _StencilRef         ("Ref", Range(0, 255)) = 0
        [IntRange]                                      _StencilReadMask    ("ReadMask", Range(0, 255)) = 255
        [IntRange]                                      _StencilWriteMask   ("WriteMask", Range(0, 255)) = 255
        [Enum(UnityEngine.Rendering.CompareFunction)]   _StencilComp        ("Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilPass        ("Pass", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilFail        ("Fail", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilZFail       ("ZFail", Float) = 0
                                                        _OffsetFactor       ("sOffsetFactor", Float) = 0
                                                        _OffsetUnits        ("sOffsetUnits", Float) = 0
        [lilColorMask]                                  _ColorMask          ("sColorMask", Int) = 15
        [lilToggle]                                     _AlphaToMask        ("sAlphaToMask", Int) = 1
                                                        _lilShadowCasterBias ("Shadow Caster Bias", Float) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Outline Advanced
        [lilEnum]                                       _OutlineCull                ("sCullModes", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineSrcBlend            ("sSrcBlendRGB", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineDstBlend            ("sDstBlendRGB", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineSrcBlendAlpha       ("sSrcBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineDstBlendAlpha       ("sDstBlendAlpha", Int) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]           _OutlineBlendOp             ("sBlendOpRGB", Int) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]           _OutlineBlendOpAlpha        ("sBlendOpAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineSrcBlendFA          ("sSrcBlendRGB", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineDstBlendFA          ("sDstBlendRGB", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineSrcBlendAlphaFA     ("sSrcBlendAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _OutlineDstBlendAlphaFA     ("sDstBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendOp)]           _OutlineBlendOpFA           ("sBlendOpRGB", Int) = 4
        [Enum(UnityEngine.Rendering.BlendOp)]           _OutlineBlendOpAlphaFA      ("sBlendOpAlpha", Int) = 4
        [lilToggle]                                     _OutlineZClip               ("sZClip", Int) = 1
        [lilToggle]                                     _OutlineZWrite              ("sZWrite", Int) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]   _OutlineZTest               ("sZTest", Int) = 2
        [IntRange]                                      _OutlineStencilRef          ("Ref", Range(0, 255)) = 0
        [IntRange]                                      _OutlineStencilReadMask     ("ReadMask", Range(0, 255)) = 255
        [IntRange]                                      _OutlineStencilWriteMask    ("WriteMask", Range(0, 255)) = 255
        [Enum(UnityEngine.Rendering.CompareFunction)]   _OutlineStencilComp         ("Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]         _OutlineStencilPass         ("Pass", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _OutlineStencilFail         ("Fail", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _OutlineStencilZFail        ("ZFail", Float) = 0
                                                        _OutlineOffsetFactor        ("sOffsetFactor", Float) = 0
                                                        _OutlineOffsetUnits         ("sOffsetUnits", Float) = 0
        [lilColorMask]                                  _OutlineColorMask           ("sColorMask", Int) = 15
        [lilToggle]                                     _OutlineAlphaToMask         ("sAlphaToMask", Int) = 1
    }

    HLSLINCLUDE
        #define LIL_RENDER 1
    ENDHLSL

    SubShader
    {
        HLSLINCLUDE
            #define LIL_FEATURE_ANIMATE_MAIN_UV
            #define LIL_FEATURE_MAIN_TONE_CORRECTION
            #define LIL_FEATURE_MAIN_GRADATION_MAP
            #define LIL_FEATURE_MAIN2ND
            #define LIL_FEATURE_MAIN3RD
            #define LIL_FEATURE_DECAL
            #define LIL_FEATURE_ANIMATE_DECAL
            #define LIL_FEATURE_LAYER_DISSOLVE
            #define LIL_FEATURE_ALPHAMASK
            #define LIL_FEATURE_SHADOW
            #define LIL_FEATURE_RECEIVE_SHADOW
            #define LIL_FEATURE_SHADOW_3RD
            #define LIL_FEATURE_SHADOW_LUT
            #define LIL_FEATURE_RIMSHADE
            #define LIL_FEATURE_EMISSION_1ST
            #define LIL_FEATURE_EMISSION_2ND
            #define LIL_FEATURE_ANIMATE_EMISSION_UV
            #define LIL_FEATURE_ANIMATE_EMISSION_MASK_UV
            #define LIL_FEATURE_EMISSION_GRADATION
            #define LIL_FEATURE_NORMAL_1ST
            #define LIL_FEATURE_NORMAL_2ND
            #define LIL_FEATURE_ANISOTROPY
            #define LIL_FEATURE_REFLECTION
            #define LIL_FEATURE_MATCAP
            #define LIL_FEATURE_MATCAP_2ND
            #define LIL_FEATURE_RIMLIGHT
            #define LIL_FEATURE_RIMLIGHT_DIRECTION
            #define LIL_FEATURE_GLITTER
            #define LIL_FEATURE_BACKLIGHT
            #define LIL_FEATURE_PARALLAX
            #define LIL_FEATURE_POM
            #define LIL_FEATURE_DISTANCE_FADE
            #define LIL_FEATURE_AUDIOLINK
            #define LIL_FEATURE_AUDIOLINK_VERTEX
            #define LIL_FEATURE_AUDIOLINK_LOCAL
            #define LIL_FEATURE_DISSOLVE
            #define LIL_FEATURE_DITHER
            #define LIL_FEATURE_IDMASK
            #define LIL_FEATURE_UDIMDISCARD
            #define LIL_FEATURE_OUTLINE_TONE_CORRECTION
            #define LIL_FEATURE_OUTLINE_RECEIVE_SHADOW
            #define LIL_FEATURE_ANIMATE_OUTLINE_UV
            #define LIL_FEATURE_FUR_COLLISION
            #define LIL_FEATURE_MainGradationTex
            #define LIL_FEATURE_MainColorAdjustMask
            #define LIL_FEATURE_Main2ndTex
            #define LIL_FEATURE_Main2ndBlendMask
            #define LIL_FEATURE_Main2ndDissolveMask
            #define LIL_FEATURE_Main2ndDissolveNoiseMask
            #define LIL_FEATURE_Main3rdTex
            #define LIL_FEATURE_Main3rdBlendMask
            #define LIL_FEATURE_Main3rdDissolveMask
            #define LIL_FEATURE_Main3rdDissolveNoiseMask
            #define LIL_FEATURE_AlphaMask
            #define LIL_FEATURE_BumpMap
            #define LIL_FEATURE_Bump2ndMap
            #define LIL_FEATURE_Bump2ndScaleMask
            #define LIL_FEATURE_AnisotropyTangentMap
            #define LIL_FEATURE_AnisotropyScaleMask
            #define LIL_FEATURE_AnisotropyShiftNoiseMask
            #define LIL_FEATURE_ShadowBorderMask
            #define LIL_FEATURE_ShadowBlurMask
            #define LIL_FEATURE_ShadowStrengthMask
            #define LIL_FEATURE_ShadowColorTex
            #define LIL_FEATURE_Shadow2ndColorTex
            #define LIL_FEATURE_Shadow3rdColorTex
            #define LIL_FEATURE_RimShadeMask
            #define LIL_FEATURE_BacklightColorTex
            #define LIL_FEATURE_SmoothnessTex
            #define LIL_FEATURE_MetallicGlossMap
            #define LIL_FEATURE_ReflectionColorTex
            #define LIL_FEATURE_ReflectionCubeTex
            #define LIL_FEATURE_MatCapTex
            #define LIL_FEATURE_MatCapBlendMask
            #define LIL_FEATURE_MatCapBumpMap
            #define LIL_FEATURE_MatCap2ndTex
            #define LIL_FEATURE_MatCap2ndBlendMask
            #define LIL_FEATURE_MatCap2ndBumpMap
            #define LIL_FEATURE_RimColorTex
            #define LIL_FEATURE_GlitterColorTex
            #define LIL_FEATURE_GlitterShapeTex
            #define LIL_FEATURE_EmissionMap
            #define LIL_FEATURE_EmissionBlendMask
            #define LIL_FEATURE_EmissionGradTex
            #define LIL_FEATURE_Emission2ndMap
            #define LIL_FEATURE_Emission2ndBlendMask
            #define LIL_FEATURE_Emission2ndGradTex
            #define LIL_FEATURE_ParallaxMap
            #define LIL_FEATURE_AudioLinkMask
            #define LIL_FEATURE_AudioLinkLocalMap
            #define LIL_FEATURE_DissolveMask
            #define LIL_FEATURE_DissolveNoiseMask
            #define LIL_FEATURE_OutlineTex
            #define LIL_FEATURE_OutlineWidthMask
            #define LIL_FEATURE_OutlineVectorTex
            #define LIL_FEATURE_FurNoiseMask
            #define LIL_FEATURE_FurMask
            #define LIL_FEATURE_FurLengthMask
            #define LIL_FEATURE_FurVectorTex
            #define LIL_OPTIMIZE_APPLY_SHADOW_FA
            #define LIL_OPTIMIZE_USE_FORWARDADD
            #define LIL_OPTIMIZE_USE_FORWARDADD_SHADOW
            #define LIL_OPTIMIZE_USE_VERTEXLIGHT
            #define LIL_FEATURE_VRCLIGHTVOLUMES
            #define LIL_FEATURE_AUDIOLINK_PACKAGE
            #pragma skip_variants LIGHTMAP_ON DYNAMICLIGHTMAP_ON LIGHTMAP_SHADOW_MIXING SHADOWS_SHADOWMASK DIRLIGHTMAP_COMBINED _MIXED_LIGHTING_SUBTRACTIVE
            #pragma target 3.5
            #pragma fragmentoption ARB_precision_hint_fastest

            #pragma skip_variants DECALS_OFF DECALS_3RT DECALS_4RT DECAL_SURFACE_GRADIENT _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
            #pragma skip_variants _ADDITIONAL_LIGHT_SHADOWS
            #pragma skip_variants _SCREEN_SPACE_OCCLUSION
        
            // ────────────────────────────── AjisaiAR injection ──────────────────────────────
            // v0.12: lilToon の LIL_CUSTOM_VERTEX_OS hook に頂点 decode を埋め込む。
            // UV6 (xy) と UV7 (xy) に bake 済 magnitude m_v_0..m_v_3 が入っている。
            // K_i が source 側の正解値 c_i に一致したときのみ originalPos に復元される。
            float _AR_K0;
            float _AR_K1;
            float _AR_K2;
            float _AR_K3;
            #define LIL_REQUIRE_APP_TEXCOORD6
            #define LIL_REQUIRE_APP_TEXCOORD7
            #define LIL_CUSTOM_VERTEX_OS \
                float _ar_disp = (input.uv6.x * _AR_K0 + input.uv6.y * _AR_K1 + input.uv7.x * _AR_K2 + input.uv7.y * _AR_K3) * (1.0/255.0); \
                positionOS.xyz -= input.normalOS * _ar_disp;

            // ── v0.31.x: texture pixel encryption (XOR PRNG / LCG)、 spec 駆動 (_MainTex / _BumpMap / _AlphaMask) ──
            // CPU 側 (TextureXorEncryptor.Encrypt) と完全に同じ式で各 pixel に XOR mask を適用する。
            // material._AR_<spec>SeedLo/Hi に焼き込まれた値は (encryption_seed XOR K_correct_packed)。
            // shader 側で TK_runtime_packed と XOR することで:
            //   TK_runtime = K_correct のとき: effective_seed = encryption_seed → 復号成立
            //   TK_runtime = 0 (locked) のとき: effective_seed != encryption_seed → 完全 noise
            // seed = 0 (= 暗号化されていない material / spec) のときは gate で decode を skip。
            //
            // 重要: vertex decode 用の _AR_K0..3 ではなく、 texture decode 専用の _AR_TK0..3 を使う。
            // SMR では _AR_K_i は BlendShape vertex 復元との二重作用を防ぐため 0 に固定されており、
            // texture decode (shader 経路のみ) には bakeKey を駆動する別 parameter が必要なため。
            // _AR_TK0..3 は ShaderLockPass の AAP layer で SMR/MR 共通に bakeKey を driving する。
            float _AR_TK0;
            float _AR_TK1;
            float _AR_TK2;
            float _AR_TK3;
            float _AR_MainTexSeedLo;
            float _AR_MainTexSeedHi;
            float4 _MainTex_TexelSize;
            Texture2D _AR_MainTexMapping;
            SamplerState sampler_AR_MainTexMapping;
            float4 _AR_MainTexMapping_TexelSize;
            float _AR_BumpMapSeedLo;
            float _AR_BumpMapSeedHi;
            float4 _BumpMap_TexelSize;
            float _AR_AlphaMaskSeedLo;
            float _AR_AlphaMaskSeedHi;
            float4 _AlphaMask_TexelSize;
            // sRGB → linear 変換 (pow(x, 2.2) 近似)。 Unity macro 不在のため自前実装。
            float3 _AR_SrgbToLinear(float3 c) { return pow(saturate(c), 2.2); }
            // 共通 helper: effective_seed = storedSeed XOR runtime_K_packed
            uint _AR_EffectiveSeed(uint storedSeed)
            {
                uint key_packed = ((uint)_AR_TK0) | (((uint)_AR_TK1) << 8) | (((uint)_AR_TK2) << 16) | (((uint)_AR_TK3) << 24);
                return storedSeed ^ key_packed;
            }
            // 共通 helper: pixel idx 用 LCG mask (R, G, B, A 4 byte 返す)
            uint _AR_PixelMask(uint effective_seed, uint2 pix, float2 texSizeWH)
            {
                uint idx = pix.y * (uint)texSizeWH.x + pix.x;
                uint s = effective_seed + idx * 2654435761u;
                s = s * 1664525u + 1013904223u;
                return s;
            }
            // RGB 3 channel decode (sRGB 変換込み)。 _MainTex / _Main2ndTex 用 (Color kind)
            float3 _AR_DecodePixelRGB(float3 col, float2 uv, uint storedSeed, float2 texSizeWH)
            {
                uint effective_seed = _AR_EffectiveSeed(storedSeed);
                uint2 pix = (uint2)(uv * texSizeWH);
                uint s = _AR_PixelMask(effective_seed, pix, texSizeWH);
                uint3 col_int = (uint3)(round(saturate(col) * 255.0));
                uint3 mask_int = uint3(s & 0xFFu, (s >> 8) & 0xFFu, (s >> 16) & 0xFFu);
                uint3 decoded_int = col_int ^ mask_int;
                float3 decoded_srgb = float3(decoded_int) * (1.0/255.0);
                return _AR_SrgbToLinear(decoded_srgb);
            }
            // RGBA 4 channel decode (sRGB 変換なし、 raw byte XOR)。 _BumpMap (Normal kind) 用
            // Unity unpack 後の DXT5nm sample 結果 (R, G, B, A) を raw に decode して lilUnpackNormalScale に渡す。
            float4 _AR_DecodePixelRGBA(float4 col, float2 uv, uint storedSeed, float2 texSizeWH)
            {
                uint effective_seed = _AR_EffectiveSeed(storedSeed);
                uint2 pix = (uint2)(uv * texSizeWH);
                uint s = _AR_PixelMask(effective_seed, pix, texSizeWH);
                uint4 col_int = (uint4)(round(saturate(col) * 255.0));
                uint4 mask_int = uint4(s & 0xFFu, (s >> 8) & 0xFFu, (s >> 16) & 0xFFu, (s >> 24) & 0xFFu);
                uint4 decoded_int = col_int ^ mask_int;
                return float4(decoded_int) * (1.0/255.0);
            }
            // R 1 channel decode (sRGB 変換なし、 raw byte XOR)。 _AlphaMask (Mask kind) 用
            float _AR_DecodePixelR(float r, float2 uv, uint storedSeed, float2 texSizeWH)
            {
                uint effective_seed = _AR_EffectiveSeed(storedSeed);
                uint2 pix = (uint2)(uv * texSizeWH);
                uint s = _AR_PixelMask(effective_seed, pix, texSizeWH);
                uint r_int = (uint)(round(saturate(r) * 255.0));
                uint mask_r = s & 0xFFu;
                uint decoded = r_int ^ mask_r;
                return float(decoded) * (1.0/255.0);
            }
            // OVERRIDE_MAIN (XorSortMapping + Phase B+): mapping から (sx, sy) と low 2 bits 取得 → encrypted を 6-bit rounded として sample → low 結合で encrypted_full 復元 → XOR decode
            // tile 内 16 pixel が同 rounded encrypted byte → BC7 ε ≈ 0 → XOR amplification なし → decoded ε ≈ 0
            #define OVERRIDE_MAIN \
                LIL_GET_MAIN_TEX \
                { \
                    uint _ar_seed_m = (((uint)_AR_MainTexSeedHi) << 16) | ((uint)_AR_MainTexSeedLo); \
                    if (_ar_seed_m != 0u) \
                    { \
                        uint _ar_kp = ((uint)_AR_TK0) | (((uint)_AR_TK1) << 8) | (((uint)_AR_TK2) << 16) | (((uint)_AR_TK3) << 24); \
                        uint _ar_es = _ar_seed_m ^ _ar_kp; \
                        float2 _ar_size = _MainTex_TexelSize.zw; \
                        uint2 _ar_pix = (uint2)(fd.uvMain * _ar_size); \
                        /* mapping texture sample at fragment uv */ \
                        float4 _ar_msmp = LIL_SAMPLE_2D_LOD(_AR_MainTexMapping, sampler_AR_MainTexMapping, fd.uvMain, 0); \
                        uint4 _ar_mb = uint4(round(saturate(_ar_msmp) * 255.0)); \
                        /* (sx, sy) を 13-bit packed から復元 */ \
                        uint _ar_sx = (_ar_mb.r << 5) | (_ar_mb.g >> 3); \
                        uint _ar_sy = ((_ar_mb.g & 0x07u) << 10) | (_ar_mb.b << 2) | (_ar_mb.a >> 6); \
                        /* low 2 bits per channel (encrypted_full の正確な復元用) */ \
                        uint _ar_lowR = (_ar_mb.a >> 4) & 0x03u; \
                        uint _ar_lowG = (_ar_mb.a >> 2) & 0x03u; \
                        uint _ar_lowB = _ar_mb.a & 0x03u; \
                        /* encrypted texture sample at sorted position (BC7 が 6-bit rounded byte をほぼ ε=0 で格納) */ \
                        float2 _ar_su = (float2(_ar_sx, _ar_sy) + 0.5) * _MainTex_TexelSize.xy; \
                        float4 _ar_smp = LIL_SAMPLE_2D_LOD(_MainTex, sampler_MainTex, _ar_su, 0); \
                        /* encrypted_full = (BC7_decoded & 0xFC) | low_from_mapping → XOR で original 復元 */ \
                        uint3 _ar_ci_high = (uint3)(round(saturate(_ar_smp.rgb) * 255.0)) & 0xFCu; \
                        uint3 _ar_low = uint3(_ar_lowR, _ar_lowG, _ar_lowB); \
                        uint3 _ar_ci = _ar_ci_high | _ar_low; \
                        /* per-pixel mask は元の global_idx ベース */ \
                        uint _ar_gi = _ar_pix.y * (uint)_ar_size.x + _ar_pix.x; \
                        uint _ar_s = _ar_es + _ar_gi * 2654435761u; \
                        _ar_s = _ar_s * 1664525u + 1013904223u; \
                        uint3 _ar_mk = uint3(_ar_s & 0xFFu, (_ar_s >> 8) & 0xFFu, (_ar_s >> 16) & 0xFFu); \
                        uint3 _ar_dec_int = _ar_ci ^ _ar_mk; \
                        float3 _ar_dec_srgb = float3(_ar_dec_int) * (1.0/255.0); \
                        fd.col = float4(_AR_SrgbToLinear(_ar_dec_srgb), _ar_smp.a); \
                    } \
                } \
                LIL_APPLY_MAIN_TONECORRECTION \
                fd.col *= _Color;
            // OVERRIDE_NORMAL_1ST (Value XOR Normal): if(_UseBumpMap) で sample → RGBA decode → lilUnpackNormalScale。
            // _BumpMap は DXT5nm BC5 import で Unity unpack 後の (R, G, B, A) を全 XOR、 抽出 PNG の法線完全破壊。
            // shader 復号後 lilUnpackNormalScale が DXT5nm packing (BA に X/Y) を考慮して normal vector を再構築する。
            #define OVERRIDE_NORMAL_1ST \
                if (_UseBumpMap) { \
                    float4 _ar_normalTex = LIL_SAMPLE_2D_ST(_BumpMap, sampler_MainTex, fd.uvMain); \
                    uint _ar_seed_n = (((uint)_AR_BumpMapSeedHi) << 16) | ((uint)_AR_BumpMapSeedLo); \
                    if (_ar_seed_n != 0u) { \
                        _ar_normalTex = _AR_DecodePixelRGBA(_ar_normalTex, fd.uvMain, _ar_seed_n, _BumpMap_TexelSize.zw); \
                    } \
                    normalmap = lilUnpackNormalScale(_ar_normalTex, _BumpScale); \
                }
            // OVERRIDE_ALPHAMASK (Value XOR Mask): if(_AlphaMaskMode) で R channel sample → decode → 4 種 mode で fd.col.a 更新。
            // _AlphaMask は R 1 channel transparency。 GBA は意味なし。
            #define OVERRIDE_ALPHAMASK \
                if (_AlphaMaskMode) { \
                    float _ar_alphaMask = 1.0; \
                    float4 _ar_amSmp = LIL_SAMPLE_2D_ST(_AlphaMask, sampler_MainTex, fd.uvMain); \
                    uint _ar_seed_m = (((uint)_AR_AlphaMaskSeedHi) << 16) | ((uint)_AR_AlphaMaskSeedLo); \
                    if (_ar_seed_m != 0u) { \
                        _ar_alphaMask = _AR_DecodePixelR(_ar_amSmp.r, fd.uvMain, _ar_seed_m, _AlphaMask_TexelSize.zw); \
                    } else { _ar_alphaMask = _ar_amSmp.r; } \
                    _ar_alphaMask = saturate(_ar_alphaMask * _AlphaMaskScale + _AlphaMaskValue); \
                    if(_AlphaMaskMode == 1) fd.col.a = _ar_alphaMask; \
                    if(_AlphaMaskMode == 2) fd.col.a = fd.col.a * _ar_alphaMask; \
                    if(_AlphaMaskMode == 3) fd.col.a = saturate(fd.col.a + _ar_alphaMask); \
                    if(_AlphaMaskMode == 4) fd.col.a = saturate(fd.col.a - _ar_alphaMask); \
                }
            // ────────────────────────────────────────────────────────────────────────────────
ENDHLSL


        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "ForwardBase"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #define LIL_PASS_FORWARD

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pipeline_brp.hlsl"
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_common.hlsl"
            // Insert functions and includes that depend on Unity here

            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward Outline
        Pass
        {
            Name "FORWARD_OUTLINE"
            Tags {"LightMode" = "ForwardBase"}

            Stencil
            {
                Ref [_OutlineStencilRef]
                ReadMask [_OutlineStencilReadMask]
                WriteMask [_OutlineStencilWriteMask]
                Comp [_OutlineStencilComp]
                Pass [_OutlineStencilPass]
                Fail [_OutlineStencilFail]
                ZFail [_OutlineStencilZFail]
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
            ZWrite [_OutlineZWrite]
            ZTest [_OutlineZTest]
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            BlendOp [_OutlineBlendOp], [_OutlineBlendOpAlpha]
            Blend [_OutlineSrcBlend] [_OutlineDstBlend], [_OutlineSrcBlendAlpha] [_OutlineDstBlendAlpha]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #define LIL_PASS_FORWARD

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pipeline_brp.hlsl"
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_common.hlsl"
            // Insert functions and includes that depend on Unity here

            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        //----------------------------------------------------------------------------------------------------------------------
        // ForwardAdd Start
        //

        // ForwardAdd
        Pass
        {
            Name "FORWARD_ADD"
            Tags {"LightMode" = "ForwardAdd"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite Off
            ZTest LEqual
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            Blend [_SrcBlendFA] [_DstBlendFA], Zero One
            BlendOp [_BlendOpFA], [_BlendOpAlphaFA]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #define LIL_PASS_FORWARDADD

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pipeline_brp.hlsl"
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_common.hlsl"
            // Insert functions and includes that depend on Unity here

            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // ForwardAdd Outline
        Pass
        {
            Name "FORWARD_ADD_OUTLINE"
            Tags {"LightMode" = "ForwardAdd"}

            Stencil
            {
                Ref [_OutlineStencilRef]
                ReadMask [_OutlineStencilReadMask]
                WriteMask [_OutlineStencilWriteMask]
                Comp [_OutlineStencilComp]
                Pass [_OutlineStencilPass]
                Fail [_OutlineStencilFail]
                ZFail [_OutlineStencilZFail]
            }
            Cull [_OutlineCull]
            ZClip [_OutlineZClip]
            ZWrite Off
            ZTest LEqual
            ColorMask [_OutlineColorMask]
            Offset [_OutlineOffsetFactor], [_OutlineOffsetUnits]
            Blend [_OutlineSrcBlendFA] [_OutlineDstBlendFA], Zero One
            BlendOp [_OutlineBlendOpFA], [_OutlineBlendOpAlphaFA]
            AlphaToMask [_OutlineAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #define LIL_PASS_FORWARDADD

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pipeline_brp.hlsl"
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_common.hlsl"
            // Insert functions and includes that depend on Unity here

            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        //
        // ForwardAdd End

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Offset 1, 1
            Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing
            #define LIL_PASS_SHADOWCASTER

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pipeline_brp.hlsl"
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_common.hlsl"
            // Insert functions and includes that depend on Unity here

            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // ShadowCaster Outline
        Pass
        {
            Name "SHADOW_CASTER_OUTLINE"
            Tags {"LightMode" = "ShadowCaster"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Offset 1, 1
            Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing
            #define LIL_PASS_SHADOWCASTER

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_OUTLINE
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pipeline_brp.hlsl"
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_common.hlsl"
            // Insert functions and includes that depend on Unity here

            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature EDITOR_VISUALIZATION
            #define LIL_PASS_META

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pipeline_brp.hlsl"
            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_common.hlsl"
            // Insert functions and includes that depend on Unity here

            #include "Packages/jp.lilxyzw.liltoon/Shader/Includes/lil_pass_meta.hlsl"

            ENDHLSL
        }

    }
    Fallback "Unlit/Texture"
}

