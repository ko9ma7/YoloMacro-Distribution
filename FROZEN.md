# YoloMacro 배포 동결 정책

이 저장소는 기존 **YoloMacro** 사용자를 위한 공개 배포 보관소입니다. 2026-08-09부터 다음 원칙으로 동결합니다.

- YoloMacro의 기준 소스와 기존 `1.4.x` 릴리스는 보존합니다.
- YoloMacro에 VisionFlow Studio의 기능·파일·릴리스를 섞지 않습니다.
- 새 기능 개발과 새 설치 패키지는 `ko9ma7/VisionFlow-Studio`에서 진행합니다.
- 이 저장소에서는 YoloMacro의 신규 기능 릴리스를 만들지 않습니다.

## 기존 설치의 활성화 유지

기존 YoloMacro 설치가 만료 때문에 갑자기 중단되지 않도록 `manifest.json`에는 YoloMacro 전용 ECDSA 서명 정책만 유지합니다.

- 최소 버전: `1.4.0`
- 자동 CoreLib 정책 버전: `1.4.2`
- 기존 전체 설치 패키지의 마지막 공개 버전: `1.4.5`
- 정책 만료: `2036-08-06T03:03:01.7716293+00:00`

이 장기 만료 정책은 동결된 기존 제품을 유지하기 위한 것입니다. VisionFlow Studio의 서명키, 활성화 manifest, 설치 파일 또는 릴리스는 이 저장소에서 관리하지 않습니다.

## 저장소 역할

| 저장소 | 역할 |
|---|---|
| `ko9ma7/YoloMacro` | YoloMacro 기준 소스 보관 |
| `ko9ma7/YoloMacro-Distribution` | 기존 YoloMacro `1.4.x` 공개 자료 및 활성화 유지 |
| `ko9ma7/VisionFlow-Studio` | VisionFlow Studio 신규 개발·문서·패키지·향후 배포 |
