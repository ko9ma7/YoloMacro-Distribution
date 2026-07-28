# YoloMacro v1.4.4 Release Notes

## Target-specific glyph OCR

- Each OCR profile can use general Tesseract, custom glyph samples, or hybrid automatic selection.
- Capture a one-character ROI or import multiple PNG/JPG/BMP samples under a label such as `0`, `9`, `A`, or a Hangul syllable.
- Samples remain project-local under `OcrData/<profile>/GlyphSamples/<label>/`.
- The recognizer segments the ROI, normalizes each glyph, selects the closest labeled sample, and assembles the result from left to right.
- Custom results use the same Contains, Exact, Regex, Number At Least and Number At Most decisions and the same runtime values as general OCR.

## Adaptive target following

- The new Target Follow mouse action starts from the first detected image and moves the pointer to its changing center.
- Local grayscale and edge matching is updated from successful frames so gradual motion, color changes and animation changes can be followed.
- Configure frame interval, maximum duration (`0` means until lost or stopped), allowed consecutive lost frames, and local search radius.

## Version status clarity

- Activation status now shows the installed application version separately from the legacy CoreLib-only automatic-update policy version.
- v1.4.4 is distributed as a complete ZIP because OCR includes managed/native runtime files and language data. Extract it to a new folder instead of copying a single DLL.
