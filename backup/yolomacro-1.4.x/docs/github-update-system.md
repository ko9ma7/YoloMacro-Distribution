# GitHub 업데이트 시스템 구성

> 1.4.0부터 이 문서의 unsigned ZIP manifest 방식은 이전 버전 기록으로만 유지됩니다. 현재 운영 기준은 [원격 활성화와 보안 업데이트 운영 가이드](REMOTE_ACTIVATION_AND_UPDATE.md)입니다. 새 배포에서 `Settings.UpdateManifestUrl`, 채널 또는 unsigned `update-manifest.json`을 사용하지 마십시오.

YoloMacro는 GitHub에 올라간 manifest JSON을 읽어 현재 설치 버전과 최신 배포 버전을 비교할 수 있습니다.

목표는 두 가지입니다.

- 실제 소스 코드는 담당자만 볼 수 있게 private repository에 보관
- 사용자는 배포용 manifest와 release zip만 받아 업데이트 가능하게 구성

## 권장 저장소 구조

### 방식 A: 소스 비공개, 배포 정보 분리

- `YoloMacro-private`: 실제 소스 코드 저장소, 담당자만 접근
- `YoloMacro-dist`: 배포용 저장소 또는 GitHub Releases 저장소

`YoloMacro-dist`에 올릴 내용:

- `manifest.json`
- 릴리즈 노트
- 설치 zip 또는 실행 파일
- 사용자용 README

이 방식은 배포 주소를 아는 사용자가 manifest와 설치 파일을 받을 수 있습니다. 단, 공개 저장소라면 주소를 모르는 사람도 검색이나 공유를 통해 접근할 수 있으므로 고객 이미지, 학습 데이터, 비밀 값은 절대 넣지 않습니다.

### 방식 B: 소스와 배포 모두 비공개

- GitHub private repository와 private release를 사용합니다.
- 업데이트 확인 또는 다운로드에는 GitHub token, 조직 권한, 별도 인증 프록시가 필요합니다.
- 토큰은 소스에 커밋하지 말고 사용자 PC 설정 파일이나 Windows 자격 증명 저장소로 관리합니다.

GitHub private repository는 URL만 알아도 접근되는 구조가 아닙니다. 권한이 없는 사용자는 링크를 알아도 파일을 받을 수 없습니다.

## manifest 필드

예시 파일:

- `YoloMacro/UpdateManifest.example.json`
- `distribution/v1.0.12/manifest.json`

주요 필드:

- `appName`: 프로그램 이름
- `version`: 최신 버전. 예: `1.0.12`
- `channel`: `stable`, `beta`, `internal`
- `title`: 업데이트 창에 보여줄 제목
- `description`: 요약 설명
- `publishedAt`: 배포 시각
- `mandatory`: 강제 업데이트 여부
- `downloadUrl`: zip 또는 exe 다운로드 주소
- `releaseNotesUrl`: 릴리즈 노트 주소
- `sha256`: 배포 파일 무결성 확인 값
- `files`: 포함 파일 목록과 개별 해시

## 앱 코드

업데이트 확인 관련 파일:

- `YoloMacro/Core/UpdateManager.cs`
- `YoloMacro/UpdateManifest.example.json`

설정 값:

- `Settings.UpdateManifestUrl`
- `Settings.UpdateChannel`

기본 흐름:

1. 설정에서 manifest URL을 저장합니다.
2. `UpdateManager.CheckAsync(Settings.UpdateManifestUrl, UpdateManager.GetInstalledVersion(), Settings.UpdateChannel)`를 호출합니다.
3. `IsUpdateAvailable`이 `true`이면 사용자에게 최신 버전, 설명, 다운로드 링크를 보여줍니다.
4. 실제 자동 다운로드와 교체는 별도 updater exe로 분리하는 것을 권장합니다.

## 버전 규칙

- Git tag: `v1.0.12`
- manifest version: `1.0.12`
- assembly version: `1.0.12.0`

채널:

- `stable`: 일반 배포
- `beta`: 테스트 담당자 배포
- `internal`: 내부 검증용

## 배포 절차 예시

```powershell
dotnet publish YoloMacro\YoloMacro.csproj -c Release -r win-x64 --self-contained false -o publish\YoloMacro
Compress-Archive -Path publish\YoloMacro\* -DestinationPath distribution\v1.0.12\YoloMacro-1.0.12.zip -Force
Get-FileHash distribution\v1.0.12\YoloMacro-1.0.12.zip -Algorithm SHA256
```

그 다음 manifest의 `sha256`, `downloadUrl`, `releaseNotesUrl`을 실제 배포 위치에 맞게 갱신합니다.

## 배포 README에 넣을 내용

- 프로그램 이름: `YoloMacro`
- 지원 기능:
  - OpenCV 이미지 탐색
  - YOLO 모델 감지
  - AOI OK/NG 기준 검사
  - ROI 게이지 퍼센트 판정
  - 폴더식 로직 템플릿
  - 사용자 템플릿 저장/삭제
  - 메모리 읽기 전용 토큰
- 주의:
  - 모델 파일과 샘플 데이터는 배포 정책에 맞게 별도 포함
  - 고객/현장 이미지가 포함된 학습 데이터는 공개 저장소에 올리지 않음
  - GitHub token, API key, Gemini key는 저장소에 커밋하지 않음
