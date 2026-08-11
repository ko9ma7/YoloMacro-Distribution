# 통합 웹 인증 운영

YoloMacro와 VisionFlow Studio의 실행 잠금은 이 공개 배포 저장소에서만 관리합니다.

- 관리 화면: `Actions` → `Unified web activation management` → `Run workflow`
- `publish`: 현재 정책을 다시 서명하고 Pages에 게시
- `rotate`: 선택 제품의 채널 코드를 새로 만들고 기존 빌드를 잠금
- `enable` / `disable`: 선택 제품의 실행 허용 또는 중지
- `product=all`: 두 제품에 같은 작업 적용

앱은 각각 `activation/yolomacro.json`, `activation/visionflow-studio.json`을 확인합니다. schema 3 정책에는 자동 만료가 없으므로 채널을 회전하거나 명시적으로 중지하지 않는 한 계속 사용할 수 있습니다.

릴리스 빌드는 현재 서명 정책을 다운로드하고 `channelId`를 바이너리에 기록하며, 같은 JSON을 배포 ZIP의 `activation/release-channel.json`으로 첨부해야 합니다. 웹 정책과 설치 채널이 다르면 앱은 새 릴리스를 요구합니다.

서명 private key는 이 저장소의 `ACTIVATION_SIGNING_KEY_PEM` GitHub Actions secret에만 저장합니다. 공개키는 `activation/public-key.pem`이며 두 제품에 동일하게 내장됩니다.
