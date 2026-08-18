# YoloMacro v1.4.3 Release Notes

Released: 2026-07-28

## OCR actions

- Tesseract-based Korean/English text and numeric recognition with reusable profiles.
- Contains, exact, regex, any-text and numeric threshold decisions.
- Named regex groups and normalized text/number/confidence runtime values.
- ROI test, preprocessing, scaling, inversion, page segmentation, whitelist and confidence controls.

## Visual dictionaries

- Capture labeled ROI samples directly from the selected target or camera.
- Classify against one target label or return the closest label across the dictionary.
- Color, grayscale and edge matching with optional multi-scale tolerance.
- Reuses existing click, key input, branch, Replay and active-learning paths.

## Workflow integration and quality

- OCR and visual-dictionary settings are supported by selective copy, bulk edit and built-in templates.
- Existing numeric values for shipped vision engines remain unchanged for project compatibility.
- Added deterministic smoke coverage for OCR text/number/regex groups, word regions and visual-dictionary classification.
- The release package includes managed/native Tesseract runtime files and English/Korean trained data.

Because v1.4.3 adds native runtime and language-data dependencies, update from an older installation by extracting the complete v1.4.3 ZIP into a new folder. Do not copy only `YoloMacro.CoreLib.dll`.
