# YoloMacro v1.4.2 Release Notes

Released: 2026-07-23

## Ordered folder and list execution

- Capturing a fresh screen after successful input no longer skips remaining folder children or the following top-level item.
- Execution continues in visible order and restarts at item zero only after reaching the list end.
- Logs show capture policy, input route, pre/post delay, and the next item.

## Rapid click and keyboard delivery

- **Rapid Click** reuses one detected position for 1 to 10,000 clicks with a configurable 0 to 1,000 ms interval. F6 cancels the loop.
- Inactive delivery sends real key-down/key-up messages for digits, letters, Space, Enter, navigation keys, and Ctrl/Alt/Shift combinations.
- It avoids a duplicate character message after Windows translates a key event, so a digit is entered once.
- Key capture stores Space as `{SPACE}`, and Interception converts syntax such as `{ENTER}` into the actual special key.

## Stable names and public navigation

- Runtime `▶` and folder `📁` markers are display-only. Repeated markers in older projects are normalized on load.
- The in-app **GitHub** button opens the public [YoloMacro-Distribution](https://github.com/ko9ma7/YoloMacro-Distribution) repository.

## Compatibility and verification

- Existing numeric mouse-action values remain unchanged, so projects created by 1.4.1 and earlier stay compatible.
- The minimum activation-compatible version remains 1.4.0 while the latest full package is 1.4.2.
- Validation covers the Release build, a real Windows inactive digit input, 2,000 rapid clicks, ordered folder continuation, 11 security/update scenarios, and vision-quality regression.
