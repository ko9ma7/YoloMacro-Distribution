# 관리자 운영 확인 프롬프트

다음 프롬프트를 운영 담당자 또는 코드 검토 AI에 그대로 제공할 수 있습니다.

```text
YoloMacro 원격 활성화와 업데이트 상태를 읽기 전용으로 점검해 주세요.

점검 대상:
1. https://ko9ma7.github.io/YoloMacro-Distribution/manifest.json 이 HTTPS 200으로 공개되는지 확인
2. schemaVersion, enabled, minimumVersion, latestVersion, publishedAt, expiresAt,
   updateUrl, releaseNotesUrl, dllVersion, dllSha256, signature 필드 확인
3. 서명 검증 전에는 enabled나 URL을 신뢰하지 말 것
4. expiresAt 만료 여부와 minimumVersion 대비 현재 프로그램 버전 확인
5. updateUrl 파일의 SHA-256이 signed dllSha256과 같은지 확인
6. 개인키, GitHub 토큰, 고객 데이터는 요청하거나 출력하지 말 것
7. DLL이나 스크립트를 실행하지 말고 상태만 보고할 것

결과 형식:
- 활성화 상태: Active / Disabled / Invalid / Expired / UpdateRequired
- 현재 버전과 최소·최신 버전
- manifest 만료 시각
- URL 및 해시 검증 결과
- 발견한 위험과 관리자가 수행할 안전한 다음 단계
```

On/Off 변경이 필요한 경우에는 위 읽기 전용 점검이 끝난 뒤 `Remote activation control` GitHub Action의 입력값을 제안하도록 요청하십시오. 개인키를 채팅이나 프롬프트에 붙여 넣지 않습니다.
