# YoloMacro 1.2.1 검증 기록

검증일: 2026-07-11

## 빌드와 사용자 화면

- `dotnet build YoloMacro.sln -c Release --no-restore`: 경고 0, 오류 0
- WPF UI 스모크: 관찰 토글을 실제로 켜고 `관찰 켜짐`과 `실제 실행과 같은 대기 적용` 문구를 확인
- 배포 게시: framework-dependent win-x64 출력 생성 및 ZIP SHA-256 확인
- GitHub Release: CycloneDX 6.2.0에서 제거된 `-j` 옵션을 `--output-format Json`으로 교체
- 개인 소유 비공개 저장소에서는 GitHub가 지원하지 않는 build provenance 증명만 건너뛰고 SHA-256, SBOM, Release 게시를 계속하도록 조건 처리

## 회귀 테스트

`artifacts/WorkflowRegressionSmoke`의 전체 시나리오가 통과했습니다.

- 관찰 실행에서 화면 캡처가 수행됨
- 관찰 실행에서 실제 입력 호출은 0회
- 액션 후 대기 300ms 설정 시 관찰 실행 경과 시간이 250ms 이상
- 폴더 하위 흐름, 프로젝트 이미지 격리, 완성형 템플릿 참조, YOLO 데이터 분리, 프로젝트 안전 검사, 업데이트 ZIP 경로 안전성 통과

## 디버깅 가설과 실행 근거

1. **가설: 관찰 모드가 액션 후 대기를 건너뛰어 목록이 과속한다.**
   - 근거: 기존 조건이 `ExecutionMode == Live`일 때만 `PostDelay`를 호출했습니다.
   - 실행 확인: 관찰 모드 300ms 대기 시나리오가 250ms 이상 걸리고 입력 호출은 0회였습니다.

2. **가설: 매 항목마다 UI Dispatcher에 선택·스크롤 작업을 쌓아 CPU와 화면 흔들림이 증가한다.**
   - 근거: 기존 `OnItemHighlight`가 모든 항목마다 `Dispatcher.BeginInvoke`를 호출했습니다.
   - 조치 확인: 엔진 스레드는 최신 항목 ID만 보관하고, UI 타이머 하나가 100ms마다 최신 항목만 반영하도록 변경했습니다. WPF UI 스모크가 교착이나 예외 없이 완료됐습니다.

3. **가설: 관찰 모드가 켜졌는지와 어떤 동작이 달라지는지 UI에서 불명확하다.**
   - 근거: 기존 토글 문구가 켜짐/꺼짐 모두 `관찰 실행`이었고 상태 문구에는 시간 동작이 표시되지 않았습니다.
   - 실행 확인: UI 스모크에서 토글 후 `관찰 켜짐`, `입력 없음`, `실제 실행과 같은 대기 적용`을 확인하고 실제 화면 이미지를 렌더링했습니다.

## 배포 파일

- 파일: `YoloMacro-v1.2.1-win-x64.zip`
- GitHub Release 크기: `181,603,482 bytes`
- GitHub Release SHA-256: `3588d92f6a11ed4090cba8e5d5d9fedb41c7762a651a3763795a1098040b9ddb`
- 이전 개발 상태: `v1.2.0` Git 태그와 `distribution/backups/YoloMacro-v1.2.0-source-backup.tar.gz`로 보관
