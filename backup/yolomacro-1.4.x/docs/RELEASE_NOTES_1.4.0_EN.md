# YoloMacro v1.4.0 Release Notes

Released: 2026-07-22

## Execution, activation and distribution

- The application shows signed activation state and provides a manual recheck from Settings.
- Activation-independent Local Diagnostics checks the core DLL, YOLO model, selected target window, and configured camera without executing macro input.
- A small GitHub button opens the private source repository through the default browser session without storing credentials in the application.
- Public release assets, signed manifests, SBOM and bilingual documentation are separated into `YoloMacro-Distribution`; source and historical internal material remain private.

## YOLO, AOI and labeling

- A selected target window or a specific camera can drive the same inspection pipeline.
- Label review and negative states, dataset quality analysis, empty-label export and duplicate-group train/validation protection are included.
- YOLO NMS and detection limits, model metadata validation, AOI adaptive tolerance and F1 threshold calibration are included.

## Secure updates

- Remote activation uses a strict ECDSA P-256 signed manifest.
- Update DLLs require the signed SHA-256 digest.
- A separate updater performs backup, atomic replacement and rollback.

## Verification

- Release solution build: 0 warnings, 0 errors.
- Remote activation and updater security scenarios: 11/11 passed.
- Workflow regression, action settings UI, YOLO/AOI/labeling quality and NuGet vulnerability checks passed in GitHub Actions.
