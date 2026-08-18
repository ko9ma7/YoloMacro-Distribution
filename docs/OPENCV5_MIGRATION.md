# VisionFlow Studio OpenCV 5 전환

VisionFlow Studio의 프로그램 버전은 `2.6.0`으로 유지하고 Windows x64 비전 런타임을 OpenCvSharp/OpenCV `5.0.0.20260806`으로 전환했습니다.

## 주요 반영 사항

- OpenCvSharp 관리 라이브러리, Windows 네이티브 런타임, GDI bitmap 확장 패키지를 모두 5.x로 통일했습니다.
- Bitmap 변환 namespace와 OpenCV 5 API 변경점을 반영했습니다.
- 특징점 기반 회전·크기 변환 탐색은 `USAC_MAGSAC` homography와 inlier 비율, 볼록성, 면적·화면 가시 범위 검증을 사용합니다.
- 매크로 엔진 시작 로그에서 실제 OpenCV 런타임 버전, 최적화 상태, 스레드 수를 확인할 수 있습니다.
- 회전·스케일 대상 재탐색과 무관한 화면 거부를 자동 회귀 테스트로 검증합니다.

## 설치 주의

- Windows x64와 .NET 8 Desktop Runtime이 필요합니다.
- ZIP 전체를 새 폴더에 압축 해제하세요.
- OpenCV 4 기반 설치 폴더에 DLL 일부만 덮어쓰지 마세요.
- CUDA 등 공급업체별 가속 백엔드는 별도 환경 검증이 필요합니다.

기준 소스와 테스트는 `ko9ma7/VisionFlow-Studio`, 공개 실행 패키지는 `ko9ma7/YoloMacro-Distribution`에서 관리합니다. `ko9ma7/YoloMacro`는 기존 상태로 유지합니다.
