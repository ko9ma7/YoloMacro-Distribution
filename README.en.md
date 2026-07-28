# YoloMacro

[한국어](README.md) · [English](README.en.md) · [Korean User Manual](docs/USER_MANUAL.md) · [English User Manual](docs/USER_MANUAL_EN.md) · [Public Documentation](https://ko9ma7.github.io/YoloMacro-Distribution/)

YoloMacro is a Windows vision-RPA and inspection application that combines OpenCV matching, YOLO object detection, AOI comparison, camera or target-window capture, branching logic, and controlled input actions in one workflow.

The current stable release is `1.4.4`. Verified binaries and public documentation live in [YoloMacro-Distribution](https://github.com/ko9ma7/YoloMacro-Distribution). Source code, historical internal material, signing keys, customer images, and datasets remain in the private source repository.

## Highlights

- Target-window or selected USB/industrial-camera input
- OpenCV template matching with ROI and preprocessing presets
- General Tesseract OCR plus target-specific labeled glyph samples, regex groups, numeric comparisons and reusable profiles
- Adaptive mouse tracking that follows a detected image until it leaves the capture surface
- Project-local visual dictionaries for labeled screen-state classification
- YOLO ONNX inference, NMS, class metadata, dataset export and quality checks
- AOI OK/NG samples, alignment ROI, adaptive tolerance and F1 calibration
- Bounding-box, polygon and assisted labeling with reviewed/negative states
- Observe mode for decision-only validation before real input is enabled
- Project safety validation, replay retention, diagnostics and performance controls
- Signed remote activation and rollback-safe DLL updates
- Ordered folder execution with a fresh capture after input, rapid clicking up to 10,000 times, and reliable inactive-window special-key input

## Start here

1. Download the latest verified ZIP from [Public Releases](https://github.com/ko9ma7/YoloMacro-Distribution/releases/latest).
2. Extract the archive and run `YoloMacro.exe`.
3. When the signed activation manifest is valid, the app starts on the **RPA Execution** tab.
4. Only disabled, expired, invalid-signature, network/response-error, or update-required states redirect to **Settings**.
5. Use **Local Diagnostics** even while disabled to verify the core DLL, YOLO model, selected target window, and configured camera.
6. Create or open a project, select a target window or camera, configure actions, then validate in **Observe** mode before real execution.

## Documentation

| Document | Purpose |
|---|---|
| [English User Manual](docs/USER_MANUAL_EN.md) | Installation, activation, target/camera selection, execution, YOLO, AOI and labeling |
| [Korean User Manual](docs/USER_MANUAL.md) | Complete Korean workflow and documentation map |
| [Inspection System Guide](docs/INSPECTION_SYSTEM_GUIDE.md) | Production-oriented target/camera and YOLO/AOI architecture |
| [YOLO Labeling and Training](docs/YOLO_LABELING_TRAINING_GUIDE.md) | Dataset capture, review, export, training and ONNX connection |
| [Remote Activation and Update](docs/REMOTE_ACTIVATION_AND_UPDATE.md) | Signed manifest, cache, updater and rollback operations |
| [Remote Activation and Update (English)](docs/REMOTE_ACTIVATION_AND_UPDATE_EN.md) | Public distribution boundary and administrator workflow |
| [OCR and Visual Dictionary Guide](docs/OCR_AND_VISUAL_DICTIONARY_GUIDE_EN.md) | Text/number decisions, runtime variables and example-driven state classification |
| [v1.4.4 English Release Notes](docs/RELEASE_NOTES_1.4.4_EN.md) | Custom glyph OCR, hybrid fallback, adaptive target tracking and version clarity |
| [v1.4.3 English Release Notes](docs/RELEASE_NOTES_1.4.3_EN.md) | General OCR, visual dictionaries and package requirements |
| [v1.4.2 English Release Notes](docs/RELEASE_NOTES_1.4.2_EN.md) | Ordered flow, rapid click, inactive key input and stable runtime names |

## Security and privacy boundary

- The application never stores a GitHub password or embeds a repository token.
- The GitHub button opens the public [YoloMacro-Distribution](https://github.com/ko9ma7/YoloMacro-Distribution) repository through the default browser session.
- The public manifest is accepted only after ECDSA P-256 signature validation.
- Update DLLs are accepted only when their SHA-256 matches the signed manifest.
- Never publish customer images, label datasets, API keys, tokens, or signing private keys.

## Build

```powershell
dotnet restore YoloMacro.sln --locked-mode
dotnet build YoloMacro.sln -c Release --no-restore
```

Runtime: Windows, .NET 8 Desktop Runtime, and the native dependencies included in the verified release package. For v1.4.4, extract the complete ZIP so the Tesseract managed/native files and `tessdata` remain together.
