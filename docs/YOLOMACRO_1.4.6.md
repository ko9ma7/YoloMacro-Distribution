# YoloMacro 1.4.6

YoloMacro 1.4.6은 기존 1.4.x 프로젝트를 보존하는 레거시 유지 릴리스입니다. 새 프로젝트와 신규 기능에는 [VisionFlow Studio 2.6](../README.md)을 사용하세요.

## 유지되는 기능

- OpenCV 이미지 찾기와 클릭, YOLO 객체 감지, AOI, OCR과 대표 이미지 사전
- 기존 프로젝트 JSON과 이미지 폴더 호환
- 입력과 분리된 동일 대상 추적, 외형 앵커와 선택적 YOLO 재탐색
- 관찰 실행, 프로젝트 검사, Replay와 복구

## 인증과 설치

- Distribution의 `yolomacro` schema 3 정책과 `ym-*` 채널만 검증합니다.
- 자동 만료가 없으며 관리자가 웹 Action에서 채널을 회전하거나 명시적으로 끌 때만 기존 빌드가 잠깁니다.
- [YoloMacro 1.4.6 릴리스](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.6)에서 전체 ZIP을 받아 새 폴더에 풉니다.
- OCR과 네이티브 런타임이 함께 필요하므로 DLL 하나만 교체하지 마세요.
