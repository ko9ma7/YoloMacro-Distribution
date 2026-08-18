# YoloMacro 1.3.0 검증 기록

검증일: 2026-07-14

## 자동 검증

| 검증 | 결과 |
|---|---|
| `dotnet restore YoloMacro.sln --locked-mode` | 통과 |
| `dotnet build YoloMacro.sln -c Release --no-restore` | 통과, 경고 0·오류 0 |
| `WorkflowRegressionSmoke` | 14개 시나리오 통과 |
| `ActionSettingsUiSmoke` | 통과, 일괄 설정·Replay UI 포함 |
| `MatchSmoke` | 통과 |
| `CaptureSmoke` | 통과 |
| Release publish (`--self-contained false`) | 통과 |
| `git diff --check` | 통과 |

1.3.0에서 추가한 회귀 시나리오:

- 모니터 하단에 42px만 남던 실제 저장 좌표를 작업 영역 안으로 복구
- 이미지 이름·다중 이미지 목록·ROI·결과 키·YOLO 클래스·AOI 프로필을 유지한 선택형 설정 복사
- 흐름 설정의 독립 복사
- 만료 Replay 세션과 고아·경로 이탈 JSONL 참조 정리
- 전체 Replay 용량 제한
- 실패 화면이 정상 복구 후 10초 안에 다시 발생해도 새 실패로 저장

## 화면 검증

- [설정 그룹 일괄 복사 화면](../artifacts/batch-settings-copy-v1.3.0.png)을 680×650에서 확인했습니다.
- [Replay 보관 설정 화면](../artifacts/main-settings-replay-v1.3.0.png)을 1100×900에서 확인했습니다.
- 그룹을 선택하기 전 적용 버튼 비활성화, 선택 후 활성화, 긴 설명 스크롤, 이미지·ROI 유지 안내를 확인했습니다.

## 알려진 별도 검증 항목

`PrioritySmoke`는 로컬의 가변 프로젝트 `nowPANG-15`에 남아 있는 무조건 `NextJumpId`를 감지해 실패합니다. 이 검사는 저장소 고정 픽스처가 아니라 사용자 프로젝트 상태에 의존하며, 1.3.0 변경 전부터 존재한 별도 프로젝트 흐름 문제입니다. 이번 변경의 빌드·회귀·UI·매칭·캡처 검증에는 영향을 주지 않습니다.

실제 외부 프로그램의 투명 보관은 대상 프로그램마다 렌더링 방식이 달라 자동 스모크에서 강제 적용하지 않았습니다. 대신 원래 핸들을 별도 보존하는 복구 경로, 새 대상·새 프로젝트·종료·처리되지 않은 예외 경로와 검은 캡처 즉시 복구를 코드 검토했습니다.
