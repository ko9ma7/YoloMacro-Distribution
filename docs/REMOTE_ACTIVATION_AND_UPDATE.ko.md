# 원격 활성화와 보안 업데이트 운영 가이드

## 목적

YoloMacro 1.4.0부터 저장소 공개 여부가 아니라 GitHub Pages의 서명된 `manifest.json`으로 핵심 기능을 On/Off 합니다. GitHub 저장소가 public이어도 `enabled=false`이면 실행할 수 없고, 저장소가 private이어도 공개 Pages manifest가 유효하면 실행할 수 있습니다.

이 기능은 MIT 라이선스를 대체하는 사용자별 인증 시스템이 아니라 전체 설비의 운용 허가를 통제하는 원격 기능 게이트입니다.

프로그램의 `GitHub 로그인/내 페이지` 버튼은 토큰이나 비밀번호를 프로그램에 저장하지 않고 기본 브라우저로 비공개 저장소를 엽니다. 브라우저가 GitHub에 로그인되어 있으면 본인 권한으로 페이지가 표시됩니다. GitHub 로그인 여부와 설비 활성화 여부는 서로 독립적이며, 활성화 판정은 아래의 서명된 manifest만 사용합니다.

원격 활성화가 꺼져 있어도 설정 화면과 상단 배너의 `로컬 자체 진단`은 사용할 수 있습니다. 이 진단은 핵심 DLL, YOLO 모델 파일, 선택 대상 창, 카메라 장치 열기/프레임 읽기, 현재 활성화 상태를 확인하지만 매크로 입력이나 생산 검사를 실행하지 않습니다. 카메라를 다른 프로그램이 독점 중이면 진단 결과에 주의로 표시될 수 있습니다.

## 시작 시 판정

기본 URL은 `https://ko9ma7.github.io/YoloMacro-Distribution/manifest.json`입니다. Private 소스·구자료는 `ko9ma7/YoloMacro`에 보관하고, 공개 서명 manifest와 검증된 배포 파일만 `ko9ma7/YoloMacro-Distribution`에 둡니다. 프로그램은 다음 조건을 모두 만족해야 실행·YOLO·AOI·라벨링 탭을 활성화합니다.

1. HTTPS이며 내장 허용목록에 있는 GitHub/Pages 호스트
2. 정확한 schema 1 필드와 자료형
3. 내장 ECDSA P-256 공개키와 일치하는 서명
4. `publishedAt <= 현재 < expiresAt`
5. `enabled=true`
6. 현재 프로그램 버전이 `minimumVersion` 이상

404, 연결 실패, 제한시간 초과, 잘못된 JSON, 필드 추가·누락, 서명 불일치, 만료는 모두 fail-closed입니다. 화면 상단에 차단 이유가 표시되고 설정 탭의 `활성화 확인`으로 재검사할 수 있습니다.

## Manifest

```json
{
  "schemaVersion": 1,
  "enabled": true,
  "minimumVersion": "1.4.0",
  "latestVersion": "1.4.0",
  "publishedAt": "2026-07-21T05:00:00.0000000+00:00",
  "expiresAt": "2026-08-04T05:00:00.0000000+00:00",
  "updateUrl": "https://github.com/ko9ma7/YoloMacro-Distribution/releases/download/v1.4.0/YoloMacro.CoreLib.dll",
  "releaseNotesUrl": "https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.0",
  "dllVersion": "1.4.0",
  "dllSha256": "64자리 SHA-256",
  "signature": "Base64 ECDSA P-256 signature"
}
```

서명은 `signature`를 제외한 필드를 고정된 순서의 UTF-8 canonical payload로 만든 뒤 SHA-256/ECDSA P-256 P1363 형식으로 생성합니다. PowerShell 7 이상에서 실행하며, 직접 문자열을 조립하지 말고 반드시 `tools/Publish-ActivationManifest.ps1`을 사용합니다.

## 관리자 On/Off

GitHub 저장소 `Settings > Secrets and variables > Actions`에 `ACTIVATION_SIGNING_KEY_PEM`을 등록합니다. 개인키는 로컬 파일 또는 GitHub Secret에만 두며 저장소, release asset, Pages, 로그에 올리지 않습니다.

GitHub Pages는 저장소 플랜과 공개 상태의 영향을 받습니다. private 저장소에서 Pages를 지원하지 않는 플랜이라면 소스 저장소를 무리하게 public으로 바꾸지 말고, manifest만 담는 별도 public 저장소를 만들어 `https://계정.github.io/제어저장소/manifest.json`을 사용하십시오. 프로그램 설정에서 URL을 변경할 수 있으며 `ko9ma7.github.io` 아래의 HTTPS 주소만 허용됩니다.

현재 저장소 자체에서 Pages 배포가 가능한 경우에만 Actions 변수 `ENABLE_GITHUB_PAGES=true`를 등록합니다. 이 변수가 없으면 Release와 DLL은 정상 배포하지만 Pages 단계는 건너뛰어, 지원되지 않는 private Pages 때문에 전체 Release가 실패하지 않습니다.

Actions의 `Remote activation control`을 실행하고 다음 값을 입력합니다.

- `enabled`: 전체 핵심 기능 On/Off
- `minimumVersion`: 실행을 허용할 최소 버전
- `latestVersion`: 최신 버전 안내 기준
- `expiresDays`: 서명 manifest 유효기간, 기본 14일
- `updateUrl`: Release의 `YoloMacro.CoreLib.dll` 직접 URL
- `releaseNotesUrl`: 해당 GitHub Release 페이지
- `dllVersion`, `dllSha256`: 배포 DLL 버전과 실제 SHA-256

CLI 예시:

```powershell
gh workflow run activation-pages.yml --repo ko9ma7/YoloMacro `
  -f enabled=false `
  -f minimumVersion=1.4.0 `
  -f latestVersion=1.4.0 `
  -f expiresDays=14 `
  -f updateUrl=https://github.com/ko9ma7/YoloMacro-Distribution/releases/download/v1.4.0/YoloMacro.CoreLib.dll `
  -f releaseNotesUrl=https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.0 `
  -f dllVersion=1.4.0 `
  -f dllSha256=실제_SHA256
```

On으로 되돌릴 때는 같은 입력에서 `enabled=true`로 다시 배포합니다. 서명이 없는 manifest를 Pages에 직접 수정하면 모든 클라이언트가 차단됩니다.

## 네트워크 장애와 캐시

기본 캐시 유예는 `0시간`입니다. 설정에서 1~168시간을 선택할 수 있지만 다음 조건이 적용됩니다.

- 정상 네트워크 응답으로 서명 검증에 성공한 활성 manifest만 캐시
- 네트워크 연결 실패와 제한시간 초과에만 캐시 사용
- 404, 잘못된 JSON, 서명 오류, `enabled=false`, 만료에는 캐시를 사용하지 않음
- 캐시 manifest의 원래 `expiresAt`을 넘겨 사용할 수 없음

무인 설비에서 GitHub 장애를 잠시 허용해야 할 때만 짧은 유예를 설정하십시오.

## 업데이트와 복구

업데이트는 활성화와 별도 단계로 테스트됩니다.

1. 서명된 manifest 재검증
2. 버전 비교
3. 허용된 GitHub HTTPS URL에서 임시 파일로 다운로드
4. 서명된 `dllSha256`과 실제 파일 SHA-256 비교
5. `%LOCALAPPDATA%\YoloMacro\Updates`에 업데이트 계획 저장
6. 프로그램 종료 후 `YoloMacro.Updater.exe` 실행
7. 기존 DLL을 `%LOCALAPPDATA%\YoloMacro\UpdateBackups`에 백업
8. 대상 디렉터리 안에서 새 파일을 원자 교체
9. 오류 또는 최종 해시 불일치 시 기존 DLL 자동 복원

업데이트 대상은 프로그램 설치 디렉터리 바로 아래의 `YoloMacro.CoreLib.dll`만 허용됩니다. manifest가 임의 파일명, 로컬 경로, 명령줄, DLL 검색 경로 또는 실행 코드를 지정할 수 없습니다. 실행 중인 DLL은 직접 덮어쓰지 않습니다.

수동 복구가 필요하면 최신 `UpdateBackups\버전\YoloMacro.CoreLib.dll`을 프로그램 종료 상태에서 설치 폴더로 복사합니다.

## 키 교체

키를 바로 바꾸면 기존 프로그램은 새 서명을 검증하지 못합니다. 다음 순서를 지킵니다.

1. 새 키 쌍 생성
2. 새 공개키를 포함한 프로그램 버전 배포
3. 기존 키로 해당 버전까지 활성화
4. 충분한 전환 기간 후 GitHub Secret을 새 개인키로 변경
5. 새 키로 manifest 재서명

개인키가 유출되면 Pages를 임의 수정하는 것만으로 해결되지 않습니다. 새 공개키가 포함된 프로그램 업데이트와 키 교체 절차를 수행해야 합니다.

## 테스트

```powershell
dotnet build YoloMacro.sln -c Debug
dotnet run --project tests\YoloMacro.SecurityTests\YoloMacro.SecurityTests.csproj -c Debug
```

테스트는 정상 활성화, 원격 Off, 404, 연결 실패, JSON 오류, 위조 서명, 만료, 최소 버전 강제, 제한 캐시, 해시 불일치, 다운로드 중단, rollback을 자동 검증합니다.
