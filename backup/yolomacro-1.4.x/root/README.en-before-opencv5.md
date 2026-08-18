# VisionFlow Studio Distribution

This repository is the **current public distribution hub for VisionFlow Studio**, the **legacy archive for YoloMacro**, and the single web-managed signing authority for both products.

[Public download page](https://ko9ma7.github.io/YoloMacro-Distribution/) · [VisionFlow Studio 2.6.0](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v2.6.0) · [Unified activation operations](docs/UNIFIED_WEB_ACTIVATION.md) · [한국어](README.md)

| Product | Status | Public version | Policy |
|---|---|---:|---|
| **VisionFlow Studio** | Current product | **2.6.0** | [`visionflow-studio.json`](activation/visionflow-studio.json) |
| YoloMacro | Maintained legacy | 1.4.6 | [`yolomacro.json`](activation/yolomacro.json) |

Use VisionFlow Studio for new installations and projects. It adds a compact action editor, purpose-based task creation, feature search, overlay configuration, multi-pattern long-term tracking, and the inherited OpenCV, YOLO, AOI, OCR, visual-dictionary and safe-execution capabilities.

In the compact editor, `Esc` closes an overlay and `Enter` applies it. Outside an overlay, the same keys cancel or save the complete settings window. Open combo boxes and multiline fields keep their normal keyboard behavior.

Download the complete [VisionFlow Studio 2.6.0 ZIP](https://github.com/ko9ma7/YoloMacro-Distribution/releases/download/v2.6.0/VisionFlow-Studio-v2.6.0-win-x64.zip), extract it into a new folder, and run `VisionFlowStudio.exe`. See the [2.6.0 release notes](docs/VISIONFLOW_STUDIO_2.6.0.md) for the complete change list.

The signing private key and GitHub Secret exist only in this repository. Policies do not expire automatically. An installed build remains usable until an administrator rotates its product channel or explicitly disables it through **Unified web activation management**.

Private source remains in `ko9ma7/VisionFlow-Studio` and `ko9ma7/YoloMacro`; this public repository contains verified packages, documentation, Pages content, signed policies and release notes only.
