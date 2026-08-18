# Update And Release Guide

> Starting with 1.4.0, follow the [signed remote activation and secure update guide](REMOTE_ACTIVATION_AND_UPDATE.md). The unsigned ZIP manifest details below are retained only as historical release documentation.

## GitHub Release Layout

Publish each release with these assets:

- `YoloMacro-vX.Y.Z-win-x64.zip`
- `update-manifest.json`
- CycloneDX `bom.json`

`.github/workflows/release.yml`이 `vX.Y.Z` 태그를 받으면 ZIP, SHA-256이 포함된 공식 매니페스트와 SBOM을 새로 생성합니다. 저장소의 `distribution/update-manifest.json`은 이전 배포 형식을 확인하기 위한 기록이며 최신 업데이트 확인에는 Release 자산이 사용됩니다.

The app checks:

```text
https://github.com/ko9ma7/YoloMacro/releases/latest/download/update-manifest.json
```

## Manifest Fields

- `Version`: semantic version without the leading `v`
- `Channel`: `stable` or `beta`
- `DownloadUrl`: release asset URL for the zip
- `ReleaseNotesUrl`: GitHub release page
- `Sha256`: SHA-256 of the zip asset
- `Files`: optional per-file metadata

## Release Steps

1. 버전, 릴리즈 노트와 검증 기록을 갱신합니다.
2. 잠금 복원, Release 빌드와 스모크 테스트를 실행합니다.
3. 소스 변경을 커밋하고 기본 브랜치에 푸시합니다.
4. 같은 커밋에 `vX.Y.Z` 태그를 만들고 푸시합니다.
5. GitHub Actions의 `Verified release`가 성공했는지 확인합니다. 워크플로가 ZIP, 공식 `update-manifest.json`, SBOM과 빌드 출처 증명을 업로드합니다.
6. Release 자산의 버전·SHA-256과 앱의 `설정 -> 업데이트 설정 -> 업데이트 확인`을 확인합니다.

## Private Repository Note

If the GitHub repository is private, release assets and raw manifest URLs may require authentication. For external users without GitHub access, publish only the manifest and zip to a public download location or use a small public updater repository that contains no private source.
