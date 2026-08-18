# Changelog

## 1.4.5 - 2026-07-28

### Added

- Tracking toggle independent from the one-time mouse/key action
- Sparse optical-flow tracking with anchored appearance re-detection
- Bounded motion prediction for short fading or occluded intervals
- Optional same-class YOLO reacquisition with position and overlap association
- OpenCV visual-identity and YOLO hybrid built-in templates
- Bulk editing and legacy-project migration for the new tracking model

### Verification

- Translation, rotation, gradual fade and three hidden-frame tracking regression
- Same-class distant-distractor association regression
- WPF action-settings smoke verification for independent click and tracking controls

## 1.4.4 - 2026-07-28

### Added

- Profile-local labeled glyph sample capture and multi-image import
- Custom glyph OCR and hybrid custom/Tesseract selection
- Adaptive target-follow mouse action with local search, template updates and lost-frame limits
- Bulk and selective-copy support for tracking settings

### Fixed

- Remote activation status now distinguishes the installed application version from the legacy CoreLib-only update policy version

### Verification

- Synthetic multi-glyph numeric recognition and numeric-threshold action test
- Moving target test with position and color changes
- Existing workflow, input, activation, YOLO, AOI and visual-dictionary regression suites

## 1.4.3 - 2026-07-28

### Added

- Tesseract OCR profiles for Korean, English and numeric recognition
- Any/contains/exact/regex/numeric-threshold OCR decisions and named-group runtime values
- Project-local visual dictionaries with labeled ROI capture, three comparison modes and multi-scale tolerance
- OCR and visual-dictionary built-in templates, selective copy and bulk-edit fields

### Changed

- Recognition results share text, number, label, confidence, regions and elapsed-time data with the existing execution, history and Replay flow
- Release packages include Tesseract managed/native runtime assets and Korean/English trained data

### Verification

- Synthetic OCR and visual-dictionary smoke tests
- Existing vision-engine numeric compatibility, bulk edit and selective copy regression checks

## 1.4.2 - 2026-07-23

### Added

- 발견 좌표를 다시 검색하지 않고 1~10,000회 실행하는 고속 반복 좌클릭과 0~1,000ms 클릭 간격
- 숫자·문자·Space·Enter·방향키·조합키를 공통 구문으로 해석하는 키 입력 처리

### Fixed

- 빠른 캡처 모드에서 성공한 액션 뒤의 나머지 폴더/목록 동작을 건너뛰던 실행 인덱스 오류
- 비활성 창에 일반 문자를 `WM_CHAR`만 보내 키 입력이 무시되던 문제
- Interception에서 `{ENTER}` 같은 특수키 구문을 개별 문자로 전송하던 문제
- 실행 강조 `▶`와 폴더 표시 `📁`가 실제 작업 이름에 저장되어 계속 늘어나던 문제
- 프로그램의 GitHub 버튼이 공개 배포 저장소 대신 Private 소스 저장소를 열던 문제

### Changed

- `액션 성공 후 새 사이클`을 `액션 후 화면 갱신`으로 명확히 하고, 입력 후 새 화면을 캡처한 뒤 다음 항목을 계속 검사하도록 수정
- 실행 로그에 동작 전/후 대기와 다음 검사 항목을 표시

## 1.4.1 - 2026-07-22

### Fixed

- 유효한 활성화 상태에서 저장된 마지막 탭 대신 `RPA 실행` 화면으로 시작
- 활성화 확인 중 임시 상태의 불필요한 설정 화면 이동 제거
- 수동 활성화·업데이트 재확인 성공 시 사용자가 보고 있던 탭 유지

### Documentation

- 한국어·영문 README, 사용자 설명서, 운영 가이드와 공개 Distribution Pages 동기화

## 1.4.0 - 2026-07-21

### Added

- ECDSA P-256 서명 GitHub Pages manifest 기반 원격 활성화 On/Off
- 기본 fail-closed 정책과 최대 168시간의 선택적 서명 캐시 유예
- 연결 제한시간, 제한된 재시도, 응답 크기 제한과 GitHub HTTPS 호스트 허용목록
- 최소 버전 강제 업데이트와 manifest 만료·위조·잘못된 응답 차단
- 허용된 `YoloMacro.CoreLib.dll` 전용 다운로드, SHA-256 재검증, 별도 updater 프로세스
- 업데이트 전 백업, 동일 디렉터리 원자 교체, 실패 시 자동 롤백
- manifest 서명 PowerShell 관리 도구와 GitHub Pages 수동 On/Off 워크플로
- 정상·비활성·404·접속 실패·JSON 오류·서명 위조·만료·강제 업데이트·해시 불일치·다운로드 중단·롤백 자동 테스트

### Changed

- 기존 unsigned release manifest 업데이트를 서명된 활성화 manifest와 분리된 업데이트 단계로 교체
- 프로그램 실행 화면에 활성화 상태 배너와 재확인 기능 추가
- MIT 라이선스 저작권자와 연도를 실제 값으로 정리

### Security

- 개인키와 GitHub 토큰은 저장소 및 로그에 포함하지 않으며 개인키는 `ACTIVATION_SIGNING_KEY_PEM` GitHub Actions Secret으로만 관리
- 원격 응답은 임의 DLL 경로, 명령, 스크립트 또는 코드를 실행할 수 없음
