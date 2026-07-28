---
title: YoloMacro Distribution
---

# YoloMacro Distribution

[한국어](#한국어) · [English](#english) · [최신 릴리즈 / Latest release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/latest)

## 한국어

YoloMacro의 공개 배포 전용 저장소입니다. 소스 코드와 내부 구자료는 Private `ko9ma7/YoloMacro`에 보존되며, 이곳에는 검증된 설치 파일·SBOM·서명 활성화 manifest·공개 사용자 문서만 제공합니다.

### 다운로드와 시작

1. [v1.4.3 릴리즈](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.3)에서 `YoloMacro-v1.4.3-win-x64.zip`을 받습니다.
2. ZIP 전체를 풀고 `YoloMacro.exe`를 실행합니다.
3. 활성화가 정상이면 **RPA 실행** 화면으로 시작합니다. 비활성·만료·서명/네트워크/응답 오류·최소 버전 미달일 때만 **설정**으로 이동합니다.
4. 설정에서 수동으로 `다시 확인`해 성공한 경우에는 현재 탭을 유지합니다.

- [한국어 전체 사용자 설명서](docs/USER_MANUAL.md)
- [OCR·대표 이미지 사전 가이드](docs/OCR_AND_VISUAL_DICTIONARY_GUIDE.md)
- [한국어 원격 활성화·업데이트 가이드](docs/REMOTE_ACTIVATION_AND_UPDATE.md)
- [한국어 v1.4.3 릴리즈 노트](docs/RELEASE_NOTES.v1.4.3.ko.md)

### v1.4.3 인식 확장

- 한국어·영문·숫자를 읽는 OCR 액션과 포함/일치/정규식/숫자 임계값 판정을 제공합니다.
- `{last.text}`, `{last.number}`, 정규식 이름 그룹을 기존 키 입력·메시지·분기에서 사용할 수 있습니다.
- 라벨별 ROI 샘플로 `ready/busy/error` 같은 상태를 구분하는 대표 이미지 사전을 제공합니다.
- 대상 창과 특정 카메라 입력, 기존 클릭·키 입력·분기·Replay·능동 학습 흐름을 그대로 사용합니다.
- OCR 런타임과 언어 데이터가 추가되었으므로 구버전에 Core DLL 하나만 덮어쓰지 말고 전체 v1.4.3 ZIP을 새 폴더에 풉니다.

## English

This is the public distribution repository for YoloMacro. Private source and historical internal material remain in `ko9ma7/YoloMacro`; this repository contains only verified release packages, SBOM, signed activation manifest, and public documentation.

### Download and start

1. Download `YoloMacro-v1.4.3-win-x64.zip` from the [v1.4.3 release](https://github.com/ko9ma7/YoloMacro-Distribution/releases/tag/v1.4.3).
2. Extract the complete archive and run `YoloMacro.exe`.
3. Valid activation opens **RPA Execution** at application startup. Only a final disabled, expired, signature/network/response error, or minimum-version failure opens **Settings**.
4. A successful manual Retry keeps the current tab.

- [English User Manual](docs/USER_MANUAL_EN.md)
- [OCR and Visual Dictionary Guide](docs/OCR_AND_VISUAL_DICTIONARY_GUIDE_EN.md)
- [English Remote Activation & Update Guide](docs/REMOTE_ACTIVATION_AND_UPDATE_EN.md)
- [English v1.4.3 Release Notes](docs/RELEASE_NOTES_1.4.3_EN.md)

### v1.4.3 recognition expansion

- OCR reads Korean, English and numeric fields with contains, exact, regex and numeric-threshold decisions.
- Text, number, confidence and named regex groups are available to existing input, message and branch actions.
- Visual dictionaries classify states such as ready/busy/error from labeled ROI samples.
- Both engines use the selected target window or camera and reuse click, key, branch, Replay and active-learning flows.
- v1.4.3 adds managed/native OCR assets and language data. Extract the complete ZIP into a new folder; do not copy only the Core DLL over an older installation.

## Integrity and privacy

The client validates the ECDSA P-256 signed [`manifest.json`](manifest.json). The manifest intentionally keeps the last CoreLib-only compatible updater version while v1.4.3 is distributed as a full ZIP. Do not publish customer images, datasets, API keys, tokens, signing keys, or private source in this repository.
