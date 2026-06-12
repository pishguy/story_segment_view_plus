part of 'segment.dart';

// Custom painter to draw the segmented circular border around the image.
class _PartialCirclePainter extends CustomPainter {
  _PartialCirclePainter({
    required this.segments, // Total number of segments
    required this.radius, // Radius of the circular border
    required this.strokeWidth, // Width of the segment strokes
    required this.gap, // Gap between segments
    required this.color, // Base color for unseen segments
    this.rotationAngle = 0.0, // Angle of rotation for segments
    required this.padding, // Padding between image and segments
    required this.segmentType, // Type of segments (dashed or circle)
    required this.seenSegments, // Number of segments marked as seen
    required this.seenColor, // Color for seen segments
  });

  final int segments;
  final double radius;
  final double strokeWidth;
  final double gap;
  final Color color;
  final double rotationAngle;
  final double padding;
  final SegmentType segmentType;
  final int seenSegments; // Added: Number of seen segments
  final Color seenColor; // Added: Color for seen segments

  @override
  void paint(Canvas canvas, Size size) {
    final adjustedRadius = radius + padding;
    final totalGapAngle = segments > 1
        ? (gap * segments) * (2 * 3.14159265359) / (2 * adjustedRadius)
        : 0.0;
    final segmentAngle = (2 * 3.14159265359 - totalGapAngle) / segments;

    for (var i = 0; i < segments; i++) {
      final baseStartAngle = i * (segmentAngle + (gap * (2 * 3.14159265359) / (2 * adjustedRadius)));
      final startAngle = baseStartAngle + rotationAngle;

      // Use seenColor for seen segments, otherwise use base color
      final paint = Paint()
        ..color = i < seenSegments ? seenColor : color
        ..style = segmentType == SegmentType.circle ? PaintingStyle.fill : PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      if (segmentType == SegmentType.dashed) {
        canvas.drawArc(
          Offset(size.width / 2 - adjustedRadius, size.height / 2 - adjustedRadius) &
          Size(adjustedRadius * 2, adjustedRadius * 2),
          startAngle,
          segmentAngle,
          false,
          paint,
        );
      } else if (segmentType == SegmentType.circle) {
        final centerAngle = startAngle + segmentAngle / 2;
        final x = size.width / 2 + adjustedRadius * math.cos(centerAngle);
        final y = size.height / 2 + adjustedRadius * math.sin(centerAngle);
        canvas.drawCircle(
          Offset(x, y),
          strokeWidth / 2,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PartialCirclePainter oldDelegate) =>
      oldDelegate.rotationAngle != rotationAngle ||
          oldDelegate.segments != segments ||
          oldDelegate.radius != radius ||
          oldDelegate.strokeWidth != strokeWidth ||
          oldDelegate.gap != gap ||
          oldDelegate.color != color ||
          oldDelegate.padding != padding ||
          oldDelegate.segmentType != segmentType ||
          oldDelegate.seenSegments != seenSegments ||
          oldDelegate.seenColor != seenColor;
}
