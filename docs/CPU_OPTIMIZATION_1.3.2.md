# CPU 회귀 수정과 실제 프로젝트 최적화 (v1.3.2)

## 원인

v1.3.1의 캡처 공유 방향은 맞았지만 두 가지 실행 비용을 충분히 제한하지 못했습니다.

1. 검색 기록이 꺼져 있으면 마지막 이미지 판정 상태가 저장되지 않아 모든 액션이 매번 새 상태로 처리됐습니다. 그 결과 액션마다 960×552 전체 미리보기 복제, 도형 그리기, BMP 메모리 인코딩이 반복됐습니다.
2. `리스트 시작 화면 1회 캡처`를 전체 프레임 Mat 변환 1회와 동일하게 구현했습니다. 실제 `nowPANG-15`는 체크 ROI 합계가 전체 화면의 약 16%이므로 사용하지 않는 픽셀까지 매 사이클 변환했습니다.

캡처가 빨라진 만큼 같은 시간에 더 많은 매칭과 UI 갱신이 실행되어 CPU가 오르는 처리량 회귀였습니다. 캡처 횟수 감소만으로 CPU 감소를 보장할 수 없으므로 미리보기, UI 이벤트, Mat 변환 범위, OpenCV 스레드와 Replay 쓰기를 함께 제한했습니다.

## 적용한 구조

- 대상 화면 캡처는 이미지 액션 수와 관계없이 리스트 검색 사이클당 정확히 한 번입니다.
- 미리보기는 항목과 결과가 계속 바뀌어도 전역 최대 4FPS입니다.
- 실행 상태 문구와 목록 강조는 100ms마다 최신 값 하나만 UI에 반영합니다.
- OpenCV ROI 누적 면적이 화면의 1/3 미만이고 검색 항목이 24개 미만이면 전체 화면 Mat을 만들지 않습니다.
- 작은 ROI는 Bitmap 복제 없이 `LockBits`로 해당 픽셀만 BGR Mat으로 변환합니다.
- ROI와 템플릿 크기가 같은 Exact 검색은 위치 후보가 하나뿐이므로 `MatchTemplate` 결과 Mat을 만들지 않고 정규화된 픽셀 거리를 직접 계산합니다.
- 작은 ROI 검색 중 OpenCV 스레드는 2개만 사용하고 실행 종료 시 원래 설정으로 복원합니다.
- 템플릿 파일의 변경 여부는 최대 초당 한 번 확인합니다. OneDrive 파일 메타데이터 조회가 매칭 횟수만큼 반복되지 않습니다.
- Replay는 항목 상태 변화 10초, 반복 실패 60초, 전체 JPEG 쓰기 2초의 최소 간격을 적용합니다.

## 실제 측정

측정 대상은 현재 사용 중인 `nowPANG-15`, LDPlayer 960×552, 체크된 OpenCV 검색 14개, 검색 사이클 대기 30ms입니다.

### 실제 프로그램 15초 동시 비교

| 실행본 | 한 코어 환산 | 작업 관리자 전체 CPU |
|---|---:|---:|
| 기존 1.3.0 실행본 | 55.3% | 1.73% |
| 수정된 빌드 | 20.2% | 0.63% |

같은 PC와 대상창에서 동시에 측정했으며 수정본은 관찰 실행으로 목록 순회, 미리보기와 판정 로그가 정상 동작하는 것을 직접 확인했습니다. 측정 구간 기준 CPU 시간은 약 64% 감소했습니다.

### 실제 프로젝트 80사이클

| OpenCV 스레드 | 변환 경로 | CPU 시간 | p50 | p95 |
|---:|---|---:|---:|---:|
| 1 | 전체 프레임 | 578ms | 35.77ms | 67.60ms |
| 1 | 적응형 ROI | 469ms | 33.07ms | 66.34ms |
| 2 | 전체 프레임 | 469ms | 35.37ms | 67.62ms |
| 2 | 적응형 ROI | 375ms | 33.64ms | 67.31ms |
| 32 | 전체 프레임 | 1,000ms | 33.40ms | 66.35ms |
| 32 | 적응형 ROI | 391ms | 34.18ms | 67.87ms |

2스레드 적응형 ROI가 가장 적은 CPU 시간을 사용했고 p95 탐색 시간은 다른 경로와 같은 수준이었습니다.

### 동일 크기 ROI 직접 비교

68×45 ROI와 템플릿을 4,000회 비교했습니다.

| 경로 | 시간 |
|---|---:|
| 직접 정규화 비교와 후보 검증 | 18ms |
| 기존 1×1 MatchTemplate 핵심 호출 | 338ms |

점수 동등성, 발견 결과와 좌표가 기존 경로와 같은지도 회귀 테스트로 확인합니다.

## 검증 명령

```powershell
dotnet build YoloMacro.sln -c Release --no-restore
dotnet run --project artifacts\WorkflowRegressionSmoke\WorkflowRegressionSmoke.csproj -c Release --no-restore
dotnet run --project artifacts\PerformanceSmoke\PerformanceSmoke.csproj -c Release --no-restore
dotnet run --project artifacts\MatchSmoke\MatchSmoke.csproj -c Release --no-restore
dotnet run --project artifacts\CaptureSmoke\CaptureSmoke.csproj -c Release --no-restore
dotnet run --project artifacts\LivePerformanceSmoke\LivePerformanceSmoke.csproj -c Release -- "프로젝트 작업공간"
```

작업 관리자 수치는 전체 CPU 부하, 대상 화면 애니메이션, 캡처 방식과 다른 프로그램의 실행 상태에 따라 달라질 수 있습니다. 이 문서의 수치는 마이크로 벤치마크 추정이 아니라 실제 프로젝트와 대상창을 사용한 이번 측정 결과입니다.
