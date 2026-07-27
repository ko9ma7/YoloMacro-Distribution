# YoloMacro 1.2.2 검증 기록

검증일: 2026-07-11

## 사용자 화면 검증

- 관찰 실행 토글을 켜 `관찰 켜짐`과 실제 실행 동일 대기 문구를 확인했습니다.
- 작업 목록에서 첫 번째 항목을 사용자가 선택한 상태로 두고 두 번째 항목을 실행 표시했습니다.
- 따라가기 기본값이 꺼진 상태에서는 첫 번째 선택이 유지되고 두 번째 항목에만 `▶`가 붙는 것을 코드 경로와 WPF UI 스모크로 확인했습니다.
- 필요할 때만 `따라가기`를 켤 수 있는 컨트롤과 도움말을 확인했습니다.

## 자동 검증

- `dotnet build YoloMacro.sln -c Release --no-restore`: 경고 0, 오류 0
- `ActionSettingsUiSmoke`: 통과
- `WorkflowRegressionSmoke`: 모든 시나리오 통과
- 관찰 실행: 캡처 수행, 실제 입력 호출 0회, 300ms 액션 후 대기 보존
- CycloneDX JSON SBOM 생성 확인

## 디버깅 가설과 근거

1. **100ms 제한만으로 목록 이동이 사라질 것이다.**
   - 반증: 선택과 `EnsureVisible()`이 남아 있어 항목 수가 많으면 100ms마다 화면이 계속 이동합니다.
   - 수정: 기본 경로에서 두 호출을 제거하고 텍스트 `▶` 표시만 갱신합니다.

2. **현재 항목 표시를 없애야 화면이 안정된다.**
   - 반증: 사용자는 현재 검사 위치 표시는 유용하다고 명확히 요청했습니다.
   - 수정: 현재 위치 표시는 유지하고 사용자 선택·스크롤 이동만 분리했습니다.

3. **자동 이동이 필요한 사용자도 있을 수 있다.**
   - 근거: 긴 목록의 먼 위치를 실제로 따라가며 진단할 때 자동 이동이 유용합니다.
   - 수정: 기본값이 꺼진 `따라가기`를 제공해 사용자가 명시적으로 선택할 때만 이동합니다.

## 로컬 배포 확인

- 파일: `YoloMacro-v1.2.2-win-x64.zip`
- 크기: `178,548,397 bytes`
- SHA-256: `a162aba595254d44f3978ec9af861788a61273d0c35c4fc2f588d5673787fd16`

GitHub Actions가 생성하는 최종 ZIP은 압축 시각 차이로 로컬 ZIP과 해시가 달라질 수 있으므로, 공개 업데이트 매니페스트는 GitHub Release 자산의 실제 해시로 최종 동기화합니다.

## GitHub Release 확인

- GitHub Actions `Verified release`: 성공
- GitHub Release ZIP 크기: `181,603,991 bytes`
- GitHub Release ZIP SHA-256: `e8819cad5051095480ea0c6c7ab3ab1598f85fe9ec0a3a8950e731bfc04087e9`
- Release 자산: ZIP, `update-manifest.json`, `bom.json`
- 원격 기본 `master`: v1.2.2 구현 커밋과 일치
