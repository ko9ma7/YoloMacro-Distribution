# YoloMacro v1.4.2 Release Notes

Released: 2026-07-23

## Ordered workflow execution

- A successful action no longer skips the remaining actions in its folder or list when fresh-screen capture is enabled.
- After mouse or keyboard input, the engine discards the old frame, captures the updated screen, and continues with the next ordered item. It restarts at item zero only after reaching the end of the list.
- Runtime logs show capture policy, input route, pre/post delay, and the next item.

## Rapid click and keyboard delivery

- **Rapid Click** reuses one detected position for 1 to 10,000 left clicks with a configurable 0 to 1,000 ms interval. F6 remains responsive during the loop.
- Inactive-window input now sends real key-down and key-up messages and supports digits, letters, Space, Enter, navigation keys, and Ctrl/Alt/Shift combinations. It avoids a duplicate character message after Windows translates the key event.
- Key capture stores Space as `{SPACE}` instead of an invisible blank. Interception converts special-key syntax such as `{ENTER}` into the corresponding physical key.

## Stable names and public navigation

- Runtime `▶` and folder `📁` markers are display-only. They are no longer persisted or multiplied, and repeated prefixes in existing projects are normalized on load.
- The in-app **GitHub** button opens the public [YoloMacro-Distribution](https://github.com/ko9ma7/YoloMacro-Distribution) repository containing verified binaries and bilingual documentation.

## Compatibility

- Existing project files remain compatible. The legacy JSON setting name `RestartCycleAfterAction` is retained, while the UI describes its corrected behavior as **Refresh screen after action**.
- The minimum compatible activation version remains `1.4.0`; the signed public manifest advertises `1.4.2` as the latest full package.
