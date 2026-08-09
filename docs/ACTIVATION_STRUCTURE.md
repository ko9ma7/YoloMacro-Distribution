# 활성화와 공개키 구조

이 배포 저장소는 서명 결과만 공개합니다. 개인키는 포함하지 않습니다.

- `manifest.json`: 기존 YoloMacro 설치본 호환 정책
- `activation/yolomacro.json`: YoloMacro 전용 정책
- `activation/visionflow-studio.json`: VisionFlow Studio 전용 정책
- `activation/public-key.pem`: 두 제품에 내장된 것과 같은 공개 검증 키
- `activation/policy.json`: 버전·URL·해시·만료 기간을 한 번에 관리하는 정책 사본

새 서명문은 `productId`까지 ECDSA P-256 서명에 포함하므로 다른 제품의 정상 서명문을 바꿔 끼울 수 없습니다. 서명문은 매주 자동 갱신되고 45일 동안 유효합니다. JSON의 날짜나 버전을 직접 수정하면 서명이 무효가 됩니다.
