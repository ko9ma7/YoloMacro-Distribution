# VisionFlow Studio Distribution

이 저장소는 **VisionFlow Studio의 공개 실행 데이터와 문서**를 제공하는 배포 허브입니다. 기준 소스와 빌드는 [`ko9ma7/VisionFlow-Studio`](https://github.com/ko9ma7/VisionFlow-Studio)에서 관리하며, [`ko9ma7/YoloMacro`](https://github.com/ko9ma7/YoloMacro)는 기존 상태의 레거시 소스로 유지합니다.

## 현재 배포

- 제품 버전: `2.6.0` (버전 번호 유지)
- 비전 런타임: OpenCvSharp/OpenCV `5.0.0.20260806`
- 플랫폼: Windows x64, .NET 8 Desktop Runtime
- 다운로드: [VisionFlow Studio 2.6.0 Release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v2.6.0)
- 직접 ZIP: [VisionFlow-Studio-v2.6.0-win-x64.zip](https://github.com/ko9ma7/YoloMacro-Distribution/releases/download/v2.6.0/VisionFlow-Studio-v2.6.0-win-x64.zip)
- 변경 내용: [VisionFlow Studio 2.6.0](docs/VISIONFLOW_STUDIO_2.6.0.md)
- OpenCV 5 전환: [OPENCV5_MIGRATION.md](docs/OPENCV5_MIGRATION.md)

ZIP 전체를 새 폴더에 풀고 `VisionFlowStudio.exe`를 실행하세요. 일부 DLL만 이전 설치에 덮어쓰면 OpenCV 4/5 런타임이 섞일 수 있으므로 지원하지 않습니다. `.sha256`과 `.manifest.json`으로 다운로드 무결성과 빌드 정보를 확인할 수 있습니다.

## 저장소 역할

| 위치 | 역할 |
|---|---|
| `VisionFlow-Studio` | 기준 소스, 테스트, Visual Studio 솔루션, 패키지 빌드 |
| `YoloMacro-Distribution` | 검증된 실행 ZIP, 해시, 릴리스 문서, 웹 인증 정책 |
| `YoloMacro` | 수정하지 않는 1.4.x 레거시 소스 |
| [`backup/`](backup/README.md) | 이전 문서·화면·OpenCV 4 배포 자산의 보존 안내 |

## 공개 경로 보존

`activation/`, `manifest.json`, Pages 워크플로는 기존 설치와 인증 호환성을 위해 루트에 유지합니다. YoloMacro 1.4.6 실행 파일은 [기존 Release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.6)에서 계속 받을 수 있습니다.

## 검증 기준

- Release 빌드 경고 0, 오류 0
- 보안·업데이터 18/18
- 대상 추적 13/13 (OpenCV 5 회전·스케일 특징점 및 오탐 거부 포함)
- 워크플로, Action Settings UI, YOLO/AOI/OCR 품질 스모크 통과
- NuGet 알려진 취약 패키지 없음
- 배포 EXE 실제 실행 및 메인 화면 확인

웹 인증 운영은 [UNIFIED_WEB_ACTIVATION.md](docs/UNIFIED_WEB_ACTIVATION.md)를 참고하세요.
