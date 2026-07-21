# YoloMacro Distribution

[한국어](#한국어) · [English](#english) · [최신 릴리즈 / Latest release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/latest)

## 한국어

YoloMacro의 공개 배포 전용 저장소입니다. 소스 코드와 내부 구자료는 Private `ko9ma7/YoloMacro`에 보존되며, 이곳에는 검증된 설치 파일·Core DLL·SBOM·서명 활성화 manifest·공개 사용자 문서만 제공합니다.

### 다운로드와 시작

1. [v1.4.1 릴리즈](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.1)에서 `YoloMacro-v1.4.1-win-x64.zip`을 받습니다.
2. ZIP 전체를 풀고 `YoloMacro.exe`를 실행합니다.
3. 활성화가 정상이면 **RPA 실행** 화면으로 시작합니다. 비활성·만료·서명/네트워크/응답 오류·최소 버전 미달일 때만 **설정**으로 이동합니다.
4. 설정에서 수동으로 `다시 확인`해 성공한 경우에는 현재 탭을 유지합니다.

- [한국어 전체 사용자 설명서](docs/USER_MANUAL.ko.md)
- [한국어 원격 활성화·업데이트 가이드](docs/REMOTE_ACTIVATION_AND_UPDATE.ko.md)
- [한국어 v1.4.1 릴리즈 노트](docs/RELEASE_NOTES.v1.4.1.ko.md)

## English

This is the public distribution repository for YoloMacro. Private source and historical internal material remain in `ko9ma7/YoloMacro`; this repository contains only verified release packages, the Core DLL, SBOM, signed activation manifest, and public documentation.

### Download and start

1. Download `YoloMacro-v1.4.1-win-x64.zip` from the [v1.4.1 release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.1).
2. Extract the complete archive and run `YoloMacro.exe`.
3. Valid activation opens **RPA Execution** at application startup. Only a final disabled, expired, signature/network/response error, or minimum-version failure opens **Settings**.
4. A successful manual Retry keeps the current tab.

- [English User Manual](docs/USER_MANUAL.en.md)
- [English Remote Activation & Update Guide](docs/REMOTE_ACTIVATION_AND_UPDATE.en.md)
- [English v1.4.1 Release Notes](docs/RELEASE_NOTES.v1.4.1.en.md)

## Integrity and privacy

The client validates the ECDSA P-256 signed [`manifest.json`](manifest.json) and the published Core DLL SHA-256. Do not publish customer images, datasets, API keys, tokens, signing keys, or private source in this repository.