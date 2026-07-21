# YoloMacro v1.4.1 Release Notes

Released: 2026-07-22

## Startup navigation

- A valid signed activation opens the **RPA Execution** tab during application startup.
- Only a final disabled, expired, invalid-signature, network/response-error, or update-required result opens **Settings**.
- The temporary activation-checking state no longer interrupts startup or redirects the user.
- A successful manual Retry or update check preserves the user's current tab.
- Startup navigation is covered by the workflow regression smoke test.

## Documentation and distribution

- Korean and English README files and user manuals describe the final 1.4.1 behavior.
- Verified binaries and public documentation are published in `YoloMacro-Distribution`.
- The source repository stays private, preserving historical material without exposing it publicly.

## Compatibility

- Existing 1.4.0 projects and settings remain compatible.
- The signed public manifest keeps 1.4.0 as the minimum compatible version and advertises 1.4.1 as the latest full package.
