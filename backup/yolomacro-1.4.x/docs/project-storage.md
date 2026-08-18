# 프로젝트 저장/열기 구조

YoloMacro `1.1.0`의 프로젝트 저장 구조는 원본 프로젝트 파일, 자동저장, 이미지 정리, 다중 인스턴스 잠금을 분리합니다.

## 폴더 구조

```text
ProjectFolder/
  project.ymacro.json
  AutoSave/
    session-{instanceId}.json
    latest.json
  Images/
    original/
    edited/
    cache/
  AOI/
  Logs/
  Backups/
  .ymacro.lock
```

## 저장 규칙

- `저장`은 현재 열린 `project.ymacro.json`만 갱신합니다.
- 저장 전 기존 프로젝트 파일은 `Backups/yyyy-MM-dd_HHmmss.project.ymacro.json` 형식으로 백업합니다.
- 실제 쓰기는 `*.tmp`에 먼저 저장한 뒤 원본 파일로 교체합니다.
- `다른 이름으로 저장`은 새 전용 폴더를 만들고 `project.ymacro.json`으로 저장합니다.
- 새 전용 폴더에는 기존 `Images`, `AOI`, `Templates` 폴더를 복사합니다.

## 자동저장 규칙

- 자동저장은 원본 프로젝트 파일을 절대 덮어쓰지 않습니다.
- 저장 위치는 `AutoSave/session-{instanceId}.json`입니다.
- 같은 프로젝트를 쓰는 현재 인스턴스의 최신 복구 파일은 `AutoSave/latest.json`에도 기록합니다.
- 읽기 전용으로 열린 프로젝트는 프로젝트 폴더 대신 사용자 로컬 앱데이터의 인스턴스별 자동저장 폴더를 사용합니다.
- 자동저장 중 미사용 이미지 정리는 실행하지 않습니다.

## 이미지 정리

미사용 이미지 삭제는 자동저장이나 일반 저장에서 실행하지 않습니다.

사용자가 `도구 > 미사용 이미지 정리`를 누르면 현재 이미지 리스트에서 참조하지 않는 PNG 목록을 보여주고, 확인을 받은 뒤 삭제합니다.

- 새 프로젝트는 사용자 로컬 앱데이터 아래에 고유한 임시 작업공간을 만들고 전용 `Images` 폴더를 사용합니다.
- 외부 이미지는 액션 설정의 `가져오기`로 현재 프로젝트에 PNG로 복사합니다.
- 파일명이 겹치지 않으면 원래 이름을 유지하고, 실제 중복일 때만 `-2`, `-3`을 붙입니다.
- 노드 삭제 시 메인 이미지와 다중 이미지 참조를 함께 검사합니다. 다른 노드에서 사용하지 않는 파일만 삭제합니다.
- 저장하지 않은 새 프로젝트의 임시 폴더는 다른 새 프로젝트와 공유되지 않습니다.

## 다중 인스턴스 잠금

프로젝트 폴더에는 `.ymacro.lock` 파일이 생성됩니다.

lock 파일에는 다음 값이 들어갑니다.

- `InstanceId`
- `ProcessId`
- `MachineName`
- `UserName`
- `ProjectPath`
- `LockedAtUtc`

다른 실행 중인 인스턴스가 같은 프로젝트를 열고 있으면 사용자는 다음 중 하나를 선택합니다.

- 읽기 전용으로 열기
- 복사본으로 열기
- 취소

종료 시 현재 인스턴스가 소유한 lock 파일만 삭제합니다.

## 기존 프로젝트 호환

기존 JSON 프로젝트는 그대로 열 수 있습니다.

- 배열 루트 JSON은 기존 `MacroItem` 목록으로 읽습니다.
- `ProjectDocument` 형식은 `SchemaVersion`이 없더라도 자동 정규화합니다.
- 누락된 `Items`, `Nodes`, `Action`, `Logic`, `ROI` 값은 기본값으로 보정합니다.
- `SchemaVersion 3`부터 폴더 조건 이미지 설정을 저장합니다. 이전 프로젝트의 폴더는 조건 옵션이 꺼진 일반 폴더로 열립니다.
