# VisionFlow Studio 2.6.0 릴리스 노트

VisionFlow Studio 2.6.0은 YoloMacro 1.4.x의 비전 자동화 기능과 프로젝트 형식을 계승하고, 새 작업 생성·설정 구조·추적·배포 경계를 정리한 최신 제품선의 첫 공개 배포입니다.

프로그램 버전은 `2.6.0`으로 유지하면서 비전 런타임을 OpenCvSharp/OpenCV `5.0.0.20260806`으로 갱신했습니다. 세부 호환성과 설치 주의사항은 [OpenCV 5 전환 문서](OPENCV5_MIGRATION.md)를 참고하세요.

## 설치와 업데이트

- 전체 파일: `VisionFlow-Studio-v2.6.0-win-x64.zip`
- 이전 OpenCV 4 패키지 보존본: `VisionFlow-Studio-v2.6.0-opencv4-backup.zip` (신규 설치에는 권장하지 않음)
- 실행 파일: `VisionFlowStudio.exe`
- 필요 환경: Windows, .NET 8 Desktop Runtime
- 설치 방법: 기존 폴더에 일부 DLL만 덮어쓰지 말고 ZIP 전체를 새 폴더에 압축 해제
- 인증: `visionflow-studio` 제품 ID와 `vfs-*` schema 3 채널

## 더 직관적인 작업 설정

- 화면에서 이미지를 캡처하면 기본적으로 OpenCV 이미지 탐색과 좌클릭 작업으로 등록합니다.
- 일반 설정은 작은 Compact 창에서 바로 편집합니다.
- 보조 기능은 체크할 때만 설정 버튼이 나타나며, 버튼을 누르면 기능별 오버레이에서 상세 값을 편집합니다.
- 오버레이는 `Esc`로 취소·닫기, `Enter`로 적용합니다. 오버레이가 닫힌 상태에서는 같은 키가 전체 설정 취소와 저장으로 동작합니다.
- 복잡한 전체 편집기는 필요한 탭으로 직접 이동할 때만 사용합니다.
- 기능 찾기와 기능 카탈로그에서 OpenCV, YOLO, AOI, OCR, 추적, 입력과 흐름 기능을 이름으로 찾을 수 있습니다.

## 찾기·추적·입력

- OpenCV 색상/회색/윤곽/전처리 프리셋과 다중 이미지 조건
- YOLO ONNX 탐지, 클래스·NMS·최대 검출 수와 데이터셋 품질 검사
- AOI OK/NG 샘플, 정렬 ROI와 임계값 자동 보정
- Tesseract OCR, 전용 글자 샘플, 정규식 그룹과 숫자 조건
- 대표 이미지 사전 기반 상태 분류
- 최대 12개 대체 패턴과 사각·다각·타원 등록 대상
- 회전·크기·밝기 변화와 짧은 가림을 연결하는 장기 적응 추적
- 마우스·키보드 입력, 누름 유지·반복·간격, 발견 위치 상대 좌표
- 관찰 실행, 실행 전 권한·경로 검사와 과도한 반복 자동 중지

## 프로젝트와 화면

- VisionFlow 전용 실행 파일, CoreLib, 설정·캐시·프로젝트 복구 경로
- Compact 작업공간, 접이식 미리보기와 별도 미리보기 창
- 목적 기반 `새 작업 만들기`와 정확한 설정 탭으로 연결되는 기능 검색
- 자동 저장 복구본과 원본 프로젝트 저장을 분리하고 프로젝트별 이미지를 격리

## 웹 인증과 릴리스

- 서명 개인키는 YoloMacro-Distribution GitHub Actions Secret에만 저장합니다.
- 정책은 자동 만료되지 않습니다.
- 관리자가 `rotate`를 실행하거나 `disable`할 때만 기존 설치가 잠깁니다.
- 릴리스 Action은 현재 서명 정책을 내려받아 채널을 바이너리에 기록합니다.
- 같은 정책을 ZIP의 `activation/release-channel.json`에 포함해 최초 오프라인 실행도 검증합니다.
- 공개 다운로드와 릴리스 노트는 YoloMacro-Distribution에서 제공합니다.

## 검증

- Release 빌드 경고 0, 오류 0
- 보안·업데이트 시나리오 18/18
- 대상 동일성 추적 시나리오 13/13 (OpenCV 5 회전·스케일 특징점 및 오탐 거부 포함)
- Workflow, Action Settings UI, YOLO/AOI/OCR 품질 스모크 통과
- NuGet 취약 패키지 없음
- GitHub Actions 패키지 생성과 공개 schema 3 서명 검증 완료

## English summary

VisionFlow Studio 2.6.0 is the current Windows vision-automation product and now uses OpenCvSharp/OpenCV 5.0.0.20260806. It inherits the YoloMacro workflow format while adding a compact action editor, opt-in overlay settings, feature search, purpose-based task creation, multi-pattern long-term tracking, stronger project isolation, and a dedicated `visionflow-studio` web-managed release channel. Extract the complete ZIP into a new folder and use Observe mode before enabling real input.
