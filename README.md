# YoloMacro Distribution

[한국어](#한국어) · [English](#english) · [최신 릴리즈 / Latest release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/latest)

## 한국어

YoloMacro의 공개 배포 전용 저장소입니다. 소스 코드와 내부 구자료는 Private `ko9ma7/YoloMacro`에 보존되며, 이곳에는 검증된 설치 파일·Core DLL·SBOM·서명 활성화 manifest·공개 사용자 문서만 제공합니다.

### 다운로드와 시작

1. [v1.4.2 릴리즈](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.2)에서 `YoloMacro-v1.4.2-win-x64.zip`을 받습니다.
2. ZIP 전체를 풀고 `YoloMacro.exe`를 실행합니다.
3. 활성화가 정상이면 **RPA 실행** 화면으로 시작합니다. 비활성·만료·서명/네트워크/응답 오류·최소 버전 미달일 때만 **설정**으로 이동합니다.
4. 설정에서 수동으로 `다시 확인`해 성공한 경우에는 현재 탭을 유지합니다.

- [한국어 전체 사용자 설명서](docs/USER_MANUAL.ko.md)
- [한국어 원격 활성화·업데이트 가이드](docs/REMOTE_ACTIVATION_AND_UPDATE.ko.md)
- [한국어 v1.4.2 릴리즈 노트](docs/RELEASE_NOTES.v1.4.2.ko.md)

### v1.4.2 실행 흐름

- 상위 목록과 조건 폴더의 하위 동작을 화면 순서대로 실행합니다. 입력 뒤 새 화면을 캡처해 다음 항목을 계속하며 목록 끝에서만 처음으로 돌아갑니다.
- `고속 반복 좌클릭`은 한 번 찾은 위치를 1~10,000회, 0~1,000ms 간격으로 클릭합니다.
- 키 감지는 `1`, `{SPACE}`, `{ENTER}`, `^c`처럼 저장하며 비활성 창에는 실제 키다운·키업 메시지를 보냅니다.
- 실행 표시 `▶`와 폴더 표시 `📁`는 이름에 저장되지 않습니다.
- 프로그램의 `GitHub` 버튼은 이 공개 Distribution 저장소를 엽니다.

## English

This is the public distribution repository for YoloMacro. Private source and historical internal material remain in `ko9ma7/YoloMacro`; this repository contains only verified release packages, the Core DLL, SBOM, signed activation manifest, and public documentation.

### Download and start

1. Download `YoloMacro-v1.4.2-win-x64.zip` from the [v1.4.2 release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.2).
2. Extract the complete archive and run `YoloMacro.exe`.
3. Valid activation opens **RPA Execution** at application startup. Only a final disabled, expired, signature/network/response error, or minimum-version failure opens **Settings**.
4. A successful manual Retry keeps the current tab.

- [English User Manual](docs/USER_MANUAL.en.md)
- [English Remote Activation & Update Guide](docs/REMOTE_ACTIVATION_AND_UPDATE.en.md)
- [English v1.4.2 Release Notes](docs/RELEASE_NOTES.v1.4.2.en.md)

### v1.4.2 execution flow

- Top-level items and matching folder children run in visible order. After input, the app captures the updated screen and continues with the next item; only the list end restarts at item zero.
- **Rapid Click** reuses one detected position for 1 to 10,000 clicks with a 0 to 1,000 ms interval.
- Key capture stores `1`, `{SPACE}`, `{ENTER}`, or `^c`, and inactive delivery sends real key-down/key-up messages.
- Runtime `▶` and folder `📁` markers are never persisted in action names.
- The in-app **GitHub** button opens this public Distribution repository.

## Integrity and privacy

The client validates the ECDSA P-256 signed [`manifest.json`](manifest.json) and the published Core DLL SHA-256. Do not publish customer images, datasets, API keys, tokens, signing keys, or private source in this repository.
