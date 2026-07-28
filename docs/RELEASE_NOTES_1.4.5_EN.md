# YoloMacro v1.4.5 Release Notes

Release date: 2026-07-28

## Same-target identity tracking

- Tracking is now independent from the mouse action.
- The selected click or key input runs once after acquisition; the pointer then follows the target without repeating the action.
- Sparse optical flow follows continuous movement and rotation.
- Anchored appearance samples provide drift-resistant local re-detection during brightness and gradual transparency changes.
- Short visually missing intervals use bounded velocity prediction.
- Hybrid mode periodically runs the loaded YOLO model and associates the nearest same-class detection with the existing track.
- Fully invisible objects remain physically unobservable; tracking stops after the configured lost-frame limit.

## Compatibility and workflow

- Legacy `Target Follow` mouse actions migrate automatically to tracking enabled with no click.
- New built-in OpenCV visual-identity and YOLO hybrid tracking templates are available.
- Tracking mode and timing values are available in selective bulk editing.
- The app, CoreLib and updater report version `1.4.5`.

## Verification

- Release build completed with zero warnings and zero errors.
- Synthetic tracking covered translation, rotation, gradual fade, three hidden frames and a distant same-class distractor.
- WPF smoke verification confirmed the separate mouse-action and tracking controls.
- Existing security, activation, update and workflow regression suites remain part of the release gate.
