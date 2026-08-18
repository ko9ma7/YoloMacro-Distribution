# 보안 및 무료 업데이트 운영

> 1.4.0부터 ECDSA 서명 GitHub Pages manifest, fail-closed 활성화, 허용된 DLL 단일 파일 업데이트와 별도 updater 롤백을 사용합니다. 최신 운영 절차는 [원격 활성화와 보안 업데이트 운영 가이드](REMOTE_ACTIVATION_AND_UPDATE.md)를 우선합니다.

YoloMacro는 유료 인증서 없이 공개 저장소에서 운영할 수 있도록 다음 방식을 사용합니다.

1. API 키는 Windows DPAPI로 암호화해 `%LocalAppData%/YoloMacro/settings.json`에 저장합니다.
2. 외부 프로젝트는 실행 전에 이미지 누락, 잘못된 점프, ROI, 순환 경로와 요구 권한을 검사합니다.
3. 처음 받은 프로젝트는 `관찰 실행`으로 확인합니다. 이 모드에서는 마우스, 키보드, 웹훅, AI 전송, 메모리 읽기, DLL 인젝션을 실행하지 않습니다.
4. 업데이트는 GitHub HTTPS 주소에서만 받고 Release ZIP의 SHA-256을 `update-manifest.json`과 대조합니다.
5. 적용 전 덮어쓸 파일을 `%LocalAppData%/YoloMacro/UpdateBackups`에 백업하며 실패하면 복원합니다.
6. 모든 변경은 CodeQL, Gitleaks 비밀정보 검사, Dependabot 검사를 거치며 태그를 푸시하면 GitHub Actions가 Windows 빌드, SBOM, SHA-256 manifest, 빌드 출처 증명을 생성합니다.

유료 Authenticode 인증서가 없으므로 Windows SmartScreen 경고를 완전히 제거할 수는 없습니다. 공개 저장소의 Release, SHA-256, GitHub 빌드 출처 증명을 함께 제공해 사용자가 파일 출처와 무결성을 확인할 수 있게 합니다.
