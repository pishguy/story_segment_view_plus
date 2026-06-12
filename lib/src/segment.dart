import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

part 'partial_circle_painter.dart';
part 'story_segment_wrapper.dart';

enum SegmentType { dashed, circle }

// A widget that displays a circular segmented border around an image, commonly used for story indicators.
class StorySegmentView extends StatelessWidget {
  StorySegmentView({
    required this.imageUrl, // URL of the image to display inside the circle
    required this.segments, // Number of segments in the circular border
    required this.radius, // Radius of the circular border
    required this.strokeWidth, // Width of the segment strokes
    required this.color, // Base color for unseen segments
    super.key,
    this.segmentGap = 2.0, // Gap between segments in the circular border
    this.errorWidget, // Widget to display if image loading fails
    this.placeholder, // Widget to display while image is loading
    this.isAnimated = false, // Controls whether segments rotate (default: false)
    this.rotationDuration = const Duration(seconds: 5), // Duration of one full rotation of segments
    this.padding = 4.0, // Padding between image and segments
    this.segmentType = SegmentType.dashed, // Type of segments (dashed or circle)
    this.seenSegments = 0, // Number of segments marked as "seen"
    this.seenColor = Colors.grey, // Color for seen segments
    this.isScaleAnimated = false, // Controls whether the central image scales (default: false)
    this.scaleIn = 0.9, // Minimum scale factor for the central image
    this.scaleOut = 1.2, // Maximum scale factor for the central image
    this.scaleDuration = const Duration(seconds: 2), // Duration of the scaling animation
    this.pulseDuration = const Duration(seconds: 1), // Duration of the pulse animation
    this.pulseColor, // Optional color for the pulsing circle (defaults to white if null)
    this.pulseExtraScale, // Optional extra scale added to scaleOut for the pulsing circle (defaults to 0.3 if null)
  });

  final String imageUrl;
  final int segments;
  final double radius;
  final double strokeWidth;
  final double segmentGap;
  final Color color;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final bool isAnimated; // Added: Enables/disables rotation animation of segments
  final Duration rotationDuration;
  final double padding;
  final SegmentType segmentType;
  final int seenSegments; // Added: Number of segments to mark as seen
  final Color seenColor; // Added: Color for segments marked as seen
  final bool isScaleAnimated; // Added: Enables/disables scaling animation of the central image
  final double scaleIn; // Added: Minimum scale for the central image animation
  final double scaleOut; // Added: Maximum scale for the central image animation
  final Duration scaleDuration;
  final Duration pulseDuration; // Added: Duration of the pulse animation
  final Color? pulseColor; // Added: Nullable color for the pulsing circle
  final double? pulseExtraScale; // Added: Nullable extra scale for the pulsing circle

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _StorySegmentWrapper(
          imageUrl: imageUrl,
          segments: segments,
          color: color,
          radius: radius,
          strokeWidth: strokeWidth,
          gap: segmentGap,
          isAnimated: isAnimated,
          rotationDuration: rotationDuration,
          padding: padding,
          segmentType: segmentType,
          seenSegments: seenSegments,
          seenColor: seenColor,
          isScaleAnimated: isScaleAnimated,
          scaleIn: scaleIn,
          scaleOut: scaleOut,
          scaleDuration: scaleDuration,
          pulseDuration: pulseDuration,
          pulseColor: pulseColor ?? Colors.white, // Default to white if pulseColor is null
          pulseExtraScale: pulseExtraScale ?? 0.3, // Default to 0.3 if pulseExtraScale is null
          placeholder: placeholder,
          errorWidget: errorWidget,
        ),
      ],
    );
  }
}
