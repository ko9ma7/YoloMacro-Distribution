# Target Identity Tracking Guide

YoloMacro 1.4.5 tracks an acquired object identity instead of repeatedly searching for one unchanged template. It follows continuous translation, rotation, brightness changes and gradual fading.

## Tracking is separate from the input action

1. The configured vision engine acquires the initial target.
2. The selected mouse action and key input run once.
   - Select `No mouse action` to follow without clicking.
   - Select `Left click` to click once and then follow.
3. When `Keep following the same acquired target` is enabled, subsequent frames move only the pointer.
4. Tracking ends after the lost-frame limit or configured maximum duration.

Legacy projects that used the old `Target Follow` mouse action are migrated to `No mouse action + tracking enabled`.

## Modes

| Mode | Behavior | Recommended use |
|---|---|---|
| Visual identity | Sparse optical flow estimates continuous motion; anchored initial and reliable intermediate appearances provide local re-detection | Gradual visual changes after image-based acquisition |
| Visual + YOLO hybrid | Adds periodic same-class YOLO re-detection and associates detections by predicted position, velocity and overlap | Large appearance changes, short occlusion or multiple objects of the same class |

YOLO is not mandatory for continuous motion and gradual fading. It becomes valuable when appearance changes abruptly or the target must be reacquired after occlusion.

## Transparency limit

Tracking remains possible while edges, texture or contrast are still visible. Once a target is fully transparent and its pixels are identical to the background, no OpenCV or YOLO model can directly observe it. YoloMacro bridges a short interval with velocity prediction, then stops at the lost-frame limit to avoid following an unrelated object.

## Recommended starting values

- Frame interval: `33ms`
- Maximum duration: `0` (unlimited)
- Lost-frame limit: `8`
- Local search radius: `120px`
- YOLO re-detection interval: `250ms`

Increase the radius for faster motion. Reduce the radius and lost-frame limit when similar nearby objects cause identity switches.

![Target identity tracking settings](../artifacts/action-settings-target-follow-v1.4.5.png)

## YOLO dataset guidance

Label the same class across rotation, scale, lighting, semi-transparent stages, partial occlusion, motion blur and real backgrounds. Include negative frames. Do not label a fully invisible object; that interval must use bounded motion prediction.

Built-in starting templates:

- `Basic search → Follow a changing target`
- `YOLO → YOLO same-target hybrid tracking`

Validate with no mouse action first, then test the intended one-time click or key input. Review the execution log for optical-flow tracking, appearance re-detection, YOLO re-detection and target reacquisition.
