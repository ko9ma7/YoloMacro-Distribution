# YoloMacro 1.4.1 User Manual

[한국어 설명서](USER_MANUAL.md) · [English Manual](USER_MANUAL_EN.md) · [Public Documentation](https://ko9ma7.github.io/YoloMacro-Distribution/)

This manual covers the normal path from installation to production-safe RPA execution, camera inspection, AOI training, YOLO labeling, and model connection.

## 1. Install and verify

1. Download `YoloMacro-v1.4.1-win-x64.zip` from the [public v1.4.1 release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.1).
2. Extract the complete ZIP. Do not run the executable from inside the archive.
3. Install the .NET 8 Desktop Runtime if Windows requests it.
4. Run `YoloMacro.exe`.
5. Confirm the green activation banner. A valid activation opens **RPA Execution** automatically.

If activation is disabled, expired, invalid, update-required, network-unavailable, or returns an invalid response, the application opens **Settings**. Use **Retry** after checking the network. A successful manual Retry or update check keeps the tab you are currently viewing. **Local Diagnostics** remains available and does not execute macro input.

## 2. Activation and GitHub access

- Manifest: `https://ko9ma7.github.io/YoloMacro-Distribution/manifest.json`
- The app validates schema, expiry, minimum version, ECDSA signature, and update URLs.
- The small **GitHub** button opens the private source page in the default browser. Browser authentication is separate from equipment activation.
- The app does not receive or store the browser's GitHub password or token.

## 3. Choose the inspection input

Open **Settings → Inspection Video Input** and choose one source:

- **Selected target window**: capture a Windows application selected through the Target menu.
- **Camera**: search devices, select the required camera index, set width and height, then run Preview.

Local Diagnostics verifies the configured camera index rather than accepting any other discovered camera as a substitute.

## 4. Create a project and target

1. Create a new project from **File**.
2. Select the application window from **Target** or choose the camera input.
3. Add a folder or action to the execution list.
4. Double-click an action and configure its image, ROI, decision type, delay, cooldown, and flow result.
5. Save the project before live validation.

Project images, labels, AOI samples, replay evidence, and settings are isolated by workspace. Do not place customer data in the public distribution repository.

## 5. Detection methods

| Situation | Recommended method |
|---|---|
| Stable icon, button or text shape | OpenCV template matching |
| Object moves, scales or has background variation | YOLO |
| Product/screen must match a normal reference | AOI |
| Filled percentage or bar level | Gauge |
| Screen must remain unchanged for a period | Frame Stability |
| Visual rule is difficult to express deterministically | Gemini-assisted judgment |

Use the smallest practical ROI. It improves speed and reduces false positives.

## 6. Safe execution workflow

1. Configure detection and branching.
2. Enable **Observe mode** first. It evaluates vision and flow but blocks mouse, keyboard, webhook, memory writes, and injection-like side effects.
3. Check scores, selected ROI, item highlighting, and logs.
4. Confirm disappear-before-repeat, cooldown, retry, and guard limits.
5. Disable Observe mode only after the decision flow is stable.
6. Use F5/F6 or the Run/Stop buttons for controlled operation.

## 7. YOLO labeling and training

1. Capture images from the current target or camera.
2. Define classes and draw bounding boxes or polygons.
3. Mark completed images as **Reviewed** and true empty images as **Negative**.
4. Run dataset quality checks for missing files, invalid geometry, class imbalance, duplicates, and incomplete reviews.
5. Export train/validation data. Identical-image groups stay in one split to prevent leakage.
6. Train externally, export to ONNX, then load the model from the YOLO menu.
7. Register model SHA-256, input size, and class names before production use.

See the canonical [YOLO labeling and training guide](YOLO_LABELING_TRAINING_GUIDE.md) for detailed training commands.

## 8. AOI inspection

1. Select the inspection ROI and optional alignment ROI.
2. Add multiple OK samples covering normal variation.
3. Add representative NG samples.
4. Select preprocessing, pixel difference, minimum defect area, and adaptive tolerance.
5. Run calibration and review the recommended F1 threshold.
6. Test unseen OK and NG images before connecting the AOI result to RPA flow.

## 9. Troubleshooting

| Symptom | Check |
|---|---|
| App starts in Settings | Read the activation message; only a non-active result should redirect there |
| Activation fails | Network, manifest URL, version, expiry, system clock and signature status |
| No camera frame | Configured camera index, exclusive use by another app, resolution and Preview |
| Target cannot be captured | Re-select target, try another capture method, verify minimized/occluded state |
| YOLO model does not load | ONNX file, runtime compatibility, class metadata and SHA-256 |
| AOI marks everything NG | ROI alignment, OK sample diversity, preprocessing and calibrated threshold |
| Repeated input occurs | Disappear-before-repeat, cooldown, retry interval and state transition |

## 10. Update and recovery

Updates use the signed public manifest and a SHA-256 verified `YoloMacro.CoreLib.dll`. The separate updater creates a backup, performs an atomic replacement, and restores the previous DLL on failure. Full release ZIPs, DLLs, manifest, SBOM and public documentation are published in `YoloMacro-Distribution`.
