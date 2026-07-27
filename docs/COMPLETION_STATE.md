# YoloMacro Completion State

Last updated: 2026-07-23

## Stable Project Baseline

- Current app version: `1.4.2`
- Current stable project save: `nowPANG-15`
- Last known safe start-button policy:
  - only one enabled start/continue image variant
  - threshold near `90%`
  - natural click
  - `RequireDisappearBeforeRepeat=true`
  - `ActionCooldownKey=start-transition`
  - `ActionCooldownMs=8000`
  - `VerifyActionResponse=false`
- Global setting baseline:
  - keep `RestartCycleAfterAction=true` (UI: `액션 후 화면 갱신`) to discard the pre-input frame, recapture, and continue with the next ordered item
  - `ClearHoverBeforeCapture=false`
  - `CaptureMode=OncePerLoop` for fast ROI scanning, or `PerItem` when screen changes between each item
  - `VisionHistoryMode=Off` or `StateChanges`; do not use `AllAttempts` for long runs

## Current Architecture

- `YoloMacro`: WPF executable and user interface.
- `YoloMacro.CoreLib.dll`: core engine, Win32 capture/input, OpenCV matching, YOLO, AOI, template manager, update manager, settings.
- `artifacts/*`: smoke tests and diagnostic programs.
- `distribution/update-manifest.json`: update metadata published as a GitHub Release asset.

## Version 1.1.0 Additions

- Folder image gates use normal OpenCV/ROI settings and skip the complete subtree when the condition is not visible.
- New unsaved projects use isolated draft workspaces, including isolated image folders.
- Recommended templates are complete editable node graphs; all jump and enable/disable references are remapped when inserted.
- Labeling exposes tool-specific controls and exports deterministic train/validation YOLO datasets.
- Transparent target recovery resets alpha, click-through style, visibility, and the non-client frame.

## Preserved Artifacts

- Pre-change compact source backup: `distribution/backups/YoloMacro-pre-ui-update-source-20260708-072352.tar.gz`
- Pre-v1.1.0 Git backup branch: `codex/backup-20260710-pre-improvements`
- Pre-v1.1.0 Git backup tag: `backup-20260710-pre-improvements`
- v1.1.0 release zip: `distribution/releases/v1.1.0/YoloMacro-v1.1.0-win-x64.zip`
- v1.1.0 source snapshot: `distribution/releases/v1.1.0/YoloMacro-v1.1.0-source.tar.gz`
- Release package folder: `distribution/releases/v1.0.13/YoloMacro-v1.0.13-win-x64/`
- Release zip: `distribution/releases/v1.0.13/YoloMacro-v1.0.13-win-x64.zip`
- Source snapshot folder: `distribution/source/YoloMacro-v1.0.13-source/`
- Source snapshot archive: `distribution/releases/v1.0.13/YoloMacro-v1.0.13-source.tar.gz`

## Regression Command

```powershell
dotnet run --project artifacts\WorkflowRegressionSmoke\WorkflowRegressionSmoke.csproj -c Release
```

The smoke harness verifies folder subtree boundaries, isolated project image paths, recommended template references, and YOLO train/validation export.

## Runtime Notes

- Fast scanning captures the full target window once and lets image actions search their own ROI on that frame until an input succeeds. With `RestartCycleAfterAction=true`, the engine discards that frame, captures the updated screen, and continues with the next ordered item. With it disabled, the next item continues on the shared frame. Reaching the end of the list is the only normal restart at item zero.
- Priority reward selection should be represented as a folder set:
  - gate image
  - ordered candidates from high value to low value
  - final confirmation button folder outside the priority gate so missed clicks can be retried on the next cycle
- Recovery nodes such as `멈춤방지` should normally stay unchecked and be activated only by stall recovery or explicit flow logic.

## Source Protection Notes

C# assemblies can be decompiled. Splitting the core into `YoloMacro.CoreLib.dll` improves structure and makes deployment boundaries clearer, but it is not copy protection by itself.

For commercial or private distribution, add a release-time obfuscation step such as ConfuserEx-compatible tooling or a paid .NET obfuscator. Keep GitHub private unless the release assets are intended to be visible.
