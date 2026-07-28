# OCR and Visual Dictionary Guide

YoloMacro 1.4.3 adds two recognition modes to the existing OpenCV, YOLO, AOI and gauge pipeline: `OCR` reads text and numbers, while `Visual Dictionary` classifies a screen state from labeled example images. Both modes use the selected target-window or camera frame, ROI, found/not-found flow, input actions, Replay and active-learning review.

## Choose the recognition mode

| Situation | Recommended mode |
|---|---|
| Stable button or icon | OpenCV |
| Moving or scale-varying object | YOLO |
| Fine deviation from a normal reference | AOI |
| Score, quantity, date or status text | OCR |
| A small set of example-driven states such as ready/busy/error | Visual Dictionary |

## Configure OCR

1. Open an action and select `Recognition engine → OCR`.
2. Limit the ROI to the text itself.
3. Start with `number` for a numeric line or `single-line` for normal text.
4. Select `kor`, `eng` or `kor+eng`. Matching trained-data files must exist in `tessdata`.
5. Choose Read Any, Contains, Exact, Regex, Number At Least or Number At Most.
6. Use `Test current ROI` to inspect recognized text, number and mean confidence.
7. Validate the branch in Observe mode before enabling live input.

![OCR action settings](../artifacts/action-settings-ocr-v1.4.3.png)

Results are exposed as `{last.text}`, `{last.number}` and `{last.confidence}`. If the result key is `score`, the same values are available as `{score.text}`, `{score.number}` and `{score.confidence}`. Named regex groups such as `^(?<value>\d+)$` become `{score.value}`.

For better accuracy, tighten the ROI first, restrict the character whitelist for numeric fields, compare Otsu and adaptive thresholding, scale small text by 2–4x, test inversion for dark backgrounds, and select the correct page-segmentation mode.

## Build a visual dictionary

1. Select `Recognition engine → Visual Dictionary`.
2. Enter a dictionary key such as `status-icons`.
3. Enter a label such as `ready`, `busy` or `error`.
4. Select the state ROI and click `Capture current ROI sample`.
5. Add several normal examples per label across expected brightness, animation and window-scale variation.
6. Set a target label, or leave it empty to return the closest label across the dictionary.
7. Use Color when color matters, Gray for lighting variation, or Edge for shape-focused matching.
8. Enable up to 50% scale tolerance only when display scaling can vary.

![Visual dictionary settings](../artifacts/action-settings-visual-dictionary-v1.4.3.png)

Samples are stored under `VisualDictionaries/<dictionary>/<label>/` inside the project workspace. The selected label is available as `{last.label}` or `{result-key.label}`.

## Production checklist

- Combine cooldown and require-disappear-before-repeat for repeated states.
- Review low-confidence and incorrect frames through Replay or the active-learning inbox.
- Keep customer captures and sample libraries in the private source or site workspace, never in the public distribution repository.
- A 1.4.3 installation must keep `Tesseract.dll`, the `x64/x86` native runtime files and `tessdata` beside the application; extract the complete release ZIP.
