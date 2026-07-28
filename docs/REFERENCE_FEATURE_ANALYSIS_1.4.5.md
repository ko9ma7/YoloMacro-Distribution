# 참고 매크로 저장소 기능 분석과 반영 결과

분석일: 2026-07-28

이번 분석의 직접 원인은 기존 1.4.4 구현이 `추적`을 마우스 액션 한 종류로 취급하고, 직전 템플릿을 계속 섞어 갱신해 배경으로 드리프트할 수 있었던 구조입니다. 1.4.5에서는 추적 상태를 입력 액션과 분리하고 동일 대상의 위치·속도·외형 후보·재탐지를 함께 관리합니다.

## 저장소별 확인 내용

| 저장소 | 확인한 강점 | YoloMacro 적용 판단 |
|---|---|---|
| [SmartMacroAI](https://github.com/TroniePh/SmartMacroAI) | 멀티스케일 비전, OCR, 녹화기, 창 탐색, 입력 백엔드, 자연스러운 이동 | 비전/입력 책임 분리와 다단계 재탐지 원칙 채택 |
| [DiademMacro](https://github.com/EomTaeWook/DiademMacro) | 순차·배치 실행 컨트롤러, 화면 캡처 관리자, 다중 이미지 검색, 입력 실행기 | 기존 YoloMacro 순차 흐름과 일괄 설정을 유지하고 추적 설정도 일괄 변경에 포함 |
| [TGMacro](https://github.com/trksyln/TGMacro) | 다중 프로필, 키·마우스 조합 트리거, 반복, 녹화 | 트리거/녹화는 후속 후보이며 이번 추적 정확도 변경에는 미포함 |
| [Easy-Macros](https://github.com/ORelio/Easy-Macros) | 키 누름·해제·타격, 마우스 누름·해제, 실행·대기 같은 원자 액션 | 기존 YoloMacro 입력 액션과 키 파서를 유지하고 추적 중 입력은 최초 1회로 명확화 |
| [SsalCapture](https://github.com/ko9ma7/SsalCapture) | 캡처·입력 백엔드, ADB, 액션 트리, 템플릿, Lua 실행 경계 | 백엔드 분리·편집 가능한 템플릿 원칙 채택, 새 OpenCV/YOLO 추적 템플릿 추가 |
| [GuidedHacking-Injector11](https://github.com/ko9ma7/GuidedHacking-Injector11) | 다양한 DLL 주입 방식 | 추적과 무관하고 보안·안정성 위험이 커서 흡수하지 않음 |
| `ko9ma7/ziego_240719` | Interception 기반 입력, 이미지 검사, 창 핸들 제어 | 기존 Interception과 비활성/실제 입력 경로에 이미 대응, 중복 이식하지 않음 |
| [boyism80/macro](https://github.com/boyism80/macro) | WPF 화면 캡처와 Python 자동화 확장 | 외부 스크립트 확장은 현재 사용자 스크립트 경계로 유지 |
| [sizel9028/Macro](https://github.com/sizel9028/Macro) | 이미지 검색, 좌표 저장, 앱플레이어 창 복구 | ROI·좌표·대상 창 복구 기능에 이미 반영된 영역으로 판단 |
| [Macro_Tree_2025](https://github.com/aoiupen/Macro_Tree_2025) | 트리 모델, 상태 관리자, 저장소, ViewModel 분리와 CI | 구 프로젝트 자동 이관과 편집 가능한 트리 템플릿을 유지 |
| [CV-Macro](https://github.com/ardszsantos/CV-Macro) | OpenCV 비전과 특정 창 캡처 결합 | 지역 재탐지와 대상 창 좌표계를 추적 파이프라인에서 재사용 |

조사 시점에 위 저장소 대부분에서 명시적 라이선스를 확인하지 못했습니다. 따라서 소스 코드를 복사하지 않고 공개 구조와 기능 아이디어만 참고해 YoloMacro 코드베이스에 독립 구현했습니다. Private 저장소 내용은 공개 배포 문서나 소스에 복사하지 않습니다.

## 1.4.5에 실제 반영한 기능

- 클릭·키 입력과 독립된 `동일 대상 계속 추적`
- 광학 흐름 기반 연속 이동 추적
- 최초 외형을 버리지 않는 다중 외형 후보 재탐지
- 짧은 가림·완전 투명 구간의 제한된 속도 예측
- YOLO 같은 클래스 중 이전 위치와 가장 일치하는 동일 개체 재결합
- OpenCV 시각 동일성 / YOLO 하이브리드 선택
- 추적 설정 일괄 변경
- 기존 `TargetFollow` 프로젝트 자동 이관
- OpenCV 및 YOLO 추적 내장 템플릿
- 이동·회전·점진 투명화와 같은 클래스 방해 대상을 포함한 회귀 검사

## 후속 후보

- 매크로 녹화 결과를 현재 트리 액션으로 변환
- 전역 키·마우스 조합 트리거와 프로필별 실행 잠금
- 추적 박스와 신뢰도 실시간 오버레이
- 라벨링 영상에서 추적 ID를 이용한 반자동 연속 프레임 라벨 전파

후속 후보는 기존 실행 안전 제한, 비활성 입력, 카메라 프레임 속도와 충돌하지 않는지 별도 검증한 뒤 단계적으로 추가해야 합니다.
