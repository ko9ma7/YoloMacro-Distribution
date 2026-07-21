# Remote Activation and Secure Update Operations

[한국어 운영 가이드](REMOTE_ACTIVATION_AND_UPDATE.md) · [English](REMOTE_ACTIVATION_AND_UPDATE_EN.md) · [Public Documentation](https://ko9ma7.github.io/YoloMacro-Distribution/)

## Purpose

YoloMacro 1.4.0 controls equipment operation through a strict ECDSA P-256 signed manifest. This is an equipment-wide feature gate, not a GitHub-login or per-user licensing system.

The private `ko9ma7/YoloMacro` repository stores source, historical internal material, workflows and the signing secret. The public `ko9ma7/YoloMacro-Distribution` repository stores only verified release assets, the signed manifest, SBOM and user documentation.

## Client validation

The application enables execution, YOLO, AOI and labeling only after all checks pass:

1. HTTPS URL on the trusted GitHub/Pages host list.
2. Exact schema and field types.
3. Valid ECDSA P-256 signature using the embedded public key.
4. `publishedAt <= now < expiresAt`.
5. `enabled=true`.
6. Installed application version meets `minimumVersion`.
7. Update and release-note URLs are trusted HTTPS locations.

Invalid JSON, 404, signature failure, expiry, remote disable and minimum-version failure are fail-closed states. Only transient network failure may use a previously verified cache, and only within the configured grace period.

## Current public endpoints

- Manifest: `https://ko9ma7.github.io/YoloMacro-Distribution/manifest.json`
- Releases: `https://github.com/ko9ma7/YoloMacro-Distribution/releases`
- Source/private operator page: `https://github.com/ko9ma7/YoloMacro`

## Enable, disable or renew

Run the private source workflow **Remote activation control** with:

- `enabled`: equipment-wide feature state
- `minimumVersion` and `latestVersion`
- `expiresDays`
- public distribution DLL and release-note URLs
- `dllVersion` and actual DLL SHA-256

The workflow signs the manifest with `ACTIVATION_SIGNING_KEY_PEM` and preserves it as the `activation-manifest` artifact. Publish only that signed artifact to the public distribution repository and Pages. Never copy the private key into code, releases, documentation or logs.

## Update safety

The client revalidates the signed manifest, downloads only from trusted HTTPS hosts, verifies the DLL SHA-256, writes an update plan under `%LOCALAPPDATA%\YoloMacro\Updates`, and launches the separate updater. The updater backs up the existing DLL, performs an atomic replacement, and restores the backup if validation or startup fails.

## GitHub button behavior

The UI button opens the private source repository in the default browser. Browser authentication and equipment activation are intentionally independent. YoloMacro never reads or stores the browser's GitHub credentials.
