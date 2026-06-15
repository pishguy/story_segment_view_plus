A customizable circular segment indicator around profile avatars, inspired by Instagram stories. Fully customizable: number of segments, stroke width, gap size, colors, animations, and more.

<p align="center">
  <img src="https://github.com/pishguy/story_segment_view_plus/raw/main/images/preview.gif" alt="Story Segment View Plus Demo">
</p>


## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  story_segment_view_plus: ^2.0.4
```

## Usage

```dart
StorySegmentView(
  imageUrl: 'url',
  color: Colors.black,
  segments: 12,
  radius: 40,
  strokeWidth: 3,
),
```

## Advance usage

```dart
StorySegmentView(
  imageUrl: 'url',
  segments: 10,
  radius: 36,
  strokeWidth: 6,
  color: Colors.white,
  seenColor: Colors.red,
  segmentGap: 2.0,
  isAnimated: true,
  padding: 4,
  scaleDuration: Duration(milliseconds: 750),
  scaleIn: 0.7,
  scaleOut: .9,
  seenSegments: 2,
  isScaleAnimated: false,
  pulseDuration: Duration(milliseconds: 550),
  segmentType: SegmentType.circle,
  rotationDuration: const Duration(seconds: 20),
  pulseColor: Colors.white,
  pulseExtraScale: .4,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
)
```


## All Parameters

| Parameter                           | Type                                             | Description |
|-------------------------------------|------------------------------------------------|-------------|
| `imageUrl`                          | `String`                                        | URL of the image. |
| `segments`                          | `int`                                          | Number of segments in the circular indicator. |
| `radius`                            | `double`                                       | Radius of the outer segment circle. |
| `strokeWidth`                       | `double`                                       | Thickness of each segment line. |
| `segmentGap`                        | `double`                                       | Gap between each segment in the indicator. |
| `color`                             | `Color`                                        | Color of the segments. |
| `placeholder`                       | `Widget Function(BuildContext, String)?`      | Widget displayed while the image is loading. |
| `errorWidget`                       | `Widget Function(BuildContext, String, Object)?` | Widget displayed if the image fails to load. |
| `isAnimated`                       | `bool` | Enables/disables rotation animation of the segments (default: false). |
| `rotationDuration`                       | `Duration` | Duration of one full rotation of the segments (default: Duration(seconds: 5)). |
| `padding`                       | `double` | Padding between the image and the segments (default: 4.0). |
| `segmentType`                       | `SegmentType` | Type of segments: dashed (line segments) or circle (dot segments) (default: dashed). |
| `seenSegments`                       | `Color` | Color of the segments marked as "seen" (default: Colors.grey). |
| `isScaleAnimated`                       | `bool` | Enables/disables scaling animation of the central image (default: false). |
| `scaleIn`                       | `double` | Minimum scale factor for the central image animation (default: 0.9). |
| `scaleOut`                       | `double` | Maximum scale factor for the central image animation (default: 1.2). |
| `scaleDuration`                       | `Duration` | Duration of the scaling animation for the central image (default: Duration(seconds: 2)). |
| `pulseDuration`                       | `Duration` | Duration of the pulsing circle animation (default: Duration(seconds: 1)). |
| `pulseColor`                       | `Color?` | Optional color of the pulsing circle that appears when scaling reaches scaleOut (default: Colors.white if null). |
| `pulseExtraScale`                       | `double?` | Optional extra scale added to scaleOut for the pulsing circle (default: 0.3 if null). |
