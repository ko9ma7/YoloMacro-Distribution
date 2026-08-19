# VisionFlow Studio OpenCV 5 전환

VisionFlow Studio의 프로그램 버전은 `2.6.0`으로 유지하고 Windows x64 비전 런타임을 OpenCvSharp/OpenCV `5.0.0.20260806`으로 전환했습니다.

## 주요 반영 사항

- OpenCvSharp 관리 라이브러리, Windows 네이티브 런타임, GDI bitmap 확장 패키지를 모두 5.x로 통일했습니다.
- Bitmap 변환 namespace와 OpenCV 5 API 변경점을 반영했습니다.
- 특징점 기반 회전·크기 변환 탐색은 `USAC_MAGSAC` homography와 inlier 비율, 볼록성, 면적·화면 가시 범위 검증을 사용합니다.
- 매크로 엔진 시작 로그에서 실제 OpenCV 런타임 버전, 최적화 상태, 스레드 수를 확인할 수 있습니다.
- 회전·스케일 대상 재탐색과 무관한 화면 거부를 자동 회귀 테스트로 검증합니다.
- 기존 회색조 색상 무시를 B/G/R 채널별 Scharr 윤곽 중 가장 강한 구조를 합치는 색상 불변 매칭으로 개선했습니다.
- 전체/Compact/일괄 설정과 ImageMax 가져오기가 같은 프리셋 정책을 사용해 저장값과 실제 실행 옵션이 어긋나지 않습니다.
- 완전히 다시 칠한 같은 구조의 검출, 다른 구조의 거부, 정밀 색상 대조와 모양 전용 비교를 OpenCV 5 회귀 테스트로 검증합니다.

## 설치 주의

- Windows x64와 .NET 8 Desktop Runtime이 필요합니다.
- ZIP 전체를 새 폴더에 압축 해제하세요.
- OpenCV 4 기반 설치 폴더에 DLL 일부만 덮어쓰지 마세요.
- CUDA 등 공급업체별 가속 백엔드는 별도 환경 검증이 필요합니다.

기준 소스와 테스트는 `ko9ma7/VisionFlow-Studio`, 공개 실행 패키지는 `ko9ma7/YoloMacro-Distribution`에서 관리합니다. `ko9ma7/YoloMacro`는 기존 상태로 유지합니다.

상세 사용법은 [색상 불변 매칭과 Mini 실행 가이드](IMAGE_MATCHING_MINI_RUN_2.6.0.md)를 참고하세요.
