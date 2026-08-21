# VisionFlow Studio Distribution

This repository is the public distribution hub for **VisionFlow Studio packages and documentation**. Canonical source and builds live in [`ko9ma7/VisionFlow-Studio`](https://github.com/ko9ma7/VisionFlow-Studio). [`ko9ma7/YoloMacro`](https://github.com/ko9ma7/YoloMacro) remains the unchanged legacy source line.

## Current package

- Product version: `2.7.0`
- Vision runtime: OpenCvSharp/OpenCV `5.0.0.20260806`
- Platform: Windows x64 with .NET 8 Desktop Runtime
- [Release and downloads](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v2.7.0)
- [OpenCV 5 migration details](docs/OPENCV5_MIGRATION.md)
- [2.7.0 release notes](docs/VISIONFLOW_STUDIO_2.7.0.md)
- [Color-invariant matching, Mini Run, and pause guide](docs/IMAGE_MATCHING_MINI_RUN_2.7.0.md)

Extract the complete ZIP into a new folder and run `VisionFlowStudio.exe`. Mixing individual OpenCV 4 and OpenCV 5 DLLs is unsupported. Use the published SHA-256 and JSON manifest to verify the package.

The 2.7.0 package combines OpenCV 5 with safe-zone target randomization, smooth natural physical cursor and Interception paths, precise final approach, legacy project compatibility, and the stale run-preflight fix.

Previous YoloMacro documents, screenshots, and the replaced VisionFlow OpenCV 4 assets are indexed under [`backup/`](backup/README.md), while legacy binaries remain available from the existing [v1.4.6 release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.6).
