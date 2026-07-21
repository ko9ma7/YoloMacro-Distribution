# YoloMacro Distribution

YoloMacro의 공개 배포 전용 저장소입니다.

- 공개 항목: 검증된 설치 ZIP, `YoloMacro.CoreLib.dll`, SBOM, ECDSA 서명 `manifest.json`
- 비공개 유지: 소스 코드, 구버전 내부 자료, 고객 이미지, 라벨 데이터셋, API 키와 서명 개인키
- 최신 배포: https://github.com/ko9ma7/YoloMacro-Distribution/releases/latest
- 활성화 manifest: https://ko9ma7.github.io/YoloMacro-Distribution/manifest.json

프로그램은 manifest의 ECDSA 서명과 DLL SHA-256을 검증합니다. 이 저장소에는 인증 토큰이나 개인키를 저장하지 않습니다.
