part of 'segment.dart';

// Internal stateful widget that manages animations and rendering of the story segment view.
class _StorySegmentWrapper extends StatefulWidget {
  _StorySegmentWrapper({
    required this.imageUrl, // URL of the image to display
    required this.segments, // Total number of segments
    required this.radius, // Radius of the circular border
    required this.strokeWidth, // Width of the segment strokes
    required this.color, // Base color for unseen segments
    this.gap = 2.0, // Gap between segments
    this.isAnimated, // Optional: Controls segment rotation animation
    required this.rotationDuration, // Duration of segment rotation
    required this.padding, // Padding between image and segments
    required this.segmentType, // Type of segments (dashed or circle)
    required this.seenSegments, // Number of segments marked as seen
    required this.seenColor, // Color for seen segments
    this.isScaleAnimated, // Optional: Controls central image scaling animation
    required this.scaleIn, // Minimum scale for the central image
    required this.scaleOut, // Maximum scale for the central image
    required this.scaleDuration, // Duration of the scaling animation
    required this.pulseDuration, // Duration of the pulsing animation
    required this.pulseColor, // Color of the pulsing circle (default handled in parent)
    required this.pulseExtraScale, // Extra scale for the pulsing circle (default handled in parent)
    this.placeholder, // Placeholder widget during image loading
    this.errorWidget, // Error widget if image fails to load
  });

  final String imageUrl;
  final int segments;
  final double radius;
  final double strokeWidth;
  final double gap;
  final Color color;
  final bool? isAnimated; // Added: Nullable, controls segment rotation (default: false)
  final Duration rotationDuration;
  final double padding;
  final SegmentType segmentType;
  final int seenSegments; // Added: Number of seen segments
  final Color seenColor; // Added: Color for seen segments
  final bool? isScaleAnimated; // Added: Nullable, controls scaling animation (default: false)
  final double scaleIn; // Added: Minimum scale factor
  final double scaleOut; // Added: Maximum scale factor
  final Duration scaleDuration;
  final Duration pulseDuration; // Added: Duration of pulse effect
  final Color pulseColor; // Added: Color of the pulsing circle
  final double pulseExtraScale; // Added: Extra scale for the pulsing circle
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;

  @override
  State<_StorySegmentWrapper> createState() => _StorySegmentWrapperState();
}

class _StorySegmentWrapperState extends State<_StorySegmentWrapper> with TickerProviderStateMixin {
  late AnimationController _rotationController; // Controller for segment rotation animation
  late AnimationController _scaleController; // Controller for central image scaling animation
  late AnimationController _pulseController; // Controller for pulsing circle animation
  late Animation<double> _scaleAnimation; // Animation for scaling the central image
  late Animation<double> _pulseScaleAnimation; // Animation for scaling the pulsing circle
  late Animation<double> _pulseOpacityAnimation; // Animation for fading the pulsing circle
  bool _shouldPulse = false; // Flag to trigger pulse animation

  @override
  void initState() {
    super.initState();
    // Initialize rotation controller for segment animation
    _rotationController = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    );
    // Initialize scale controller for central image animation
    _scaleController = AnimationController(
      vsync: this,
      duration: widget.scaleDuration,
    );
    // Initialize pulse controller for pulsing circle animation
    _pulseController = AnimationController(
      vsync: this,
      duration: widget.pulseDuration,
    );

    // Define scaling animation from scaleIn to scaleOut with easing curve
    _scaleAnimation = Tween<double>(begin: widget.scaleIn, end: widget.scaleOut)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_scaleController)
      ..addListener(() {
        // Trigger pulse animation when scale reaches scaleOut (with tolerance)
        if (widget.isScaleAnimated! && _scaleAnimation.value >= widget.scaleOut - 0.01) {
          if (!_shouldPulse) {
            _shouldPulse = true;
            _pulseController.forward(from: 0);
          }
        } else {
          _shouldPulse = false;
        }
      });

    // Define pulse scaling animation from 0 to (scaleOut + pulseExtraScale) with easing curve
    _pulseScaleAnimation = Tween<double>(begin: 0.0, end: widget.scaleOut + widget.pulseExtraScale)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_pulseController)
      ..addStatusListener((status) {
        // Reset pulse animation when completed
        if (status == AnimationStatus.completed) {
          _pulseController.reset();
          _shouldPulse = false;
        }
      });

    // Define pulse opacity animation from fully opaque to fully transparent
    _pulseOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_pulseController);

    // Start rotation animation if enabled
    if (widget.isAnimated!) {
      _rotationController.repeat();
    }
    // Start scaling animation if enabled
    if (widget.isScaleAnimated!) {
      _scaleController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_StorySegmentWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update rotation duration and restart if changed
    if (widget.rotationDuration != oldWidget.rotationDuration) {
      _rotationController.duration = widget.rotationDuration;
      if (widget.isAnimated! && !_rotationController.isAnimating) {
        _rotationController.repeat();
      }
    }
    // Update scaling and pulse animations if related parameters change
    if (widget.scaleDuration != oldWidget.scaleDuration ||
        widget.scaleIn != oldWidget.scaleIn ||
        widget.scaleOut != oldWidget.scaleOut ||
        widget.pulseExtraScale != oldWidget.pulseExtraScale ||
        widget.pulseColor != oldWidget.pulseColor) {
      _scaleController.duration = widget.scaleDuration;
      _scaleAnimation = Tween<double>(begin: widget.scaleIn, end: widget.scaleOut)
          .chain(CurveTween(curve: Curves.easeInOut))
          .animate(_scaleController);
      _pulseScaleAnimation = Tween<double>(begin: 0.0, end: widget.scaleOut + widget.pulseExtraScale)
          .chain(CurveTween(curve: Curves.easeOut))
          .animate(_pulseController);
      if (widget.isScaleAnimated! && !_scaleController.isAnimating) {
        _scaleController.repeat(reverse: true);
      }
    }
    // Update pulse duration if changed
    if (widget.pulseDuration != oldWidget.pulseDuration) {
      _pulseController.duration = widget.pulseDuration;
    }
    // Handle changes in isAnimated state
    if (widget.isAnimated! != oldWidget.isAnimated) {
      if (widget.isAnimated!) {
        _rotationController.repeat();
      } else {
        _rotationController.stop();
        _rotationController.value = 0;
      }
    }
    // Handle changes in isScaleAnimated state
    if (widget.isScaleAnimated! != oldWidget.isScaleAnimated) {
      if (widget.isScaleAnimated!) {
        _scaleController.repeat(reverse: true);
      } else {
        _scaleController.stop();
        _scaleController.value = 0;
        _pulseController.stop();
        _pulseController.reset();
        _shouldPulse = false;
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _scaleController, _pulseController]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Render the rotating segments
            CustomPaint(
              size: Size(widget.radius * 2, widget.radius * 2),
              painter: _PartialCirclePainter(
                color: widget.color,
                segments: widget.segments,
                radius: widget.radius,
                strokeWidth: widget.strokeWidth,
                gap: widget.gap,
                rotationAngle: widget.isAnimated! ? _rotationController.value * 2 * 3.14159265359 : 0.0,
                padding: widget.padding,
                segmentType: widget.segmentType,
                seenSegments: widget.seenSegments,
                seenColor: widget.seenColor,
              ),
            ),
            // Render the central image with scaling animation
            Transform.scale(
              scale: widget.isScaleAnimated! ? _scaleAnimation.value : 1.0,
              child: Container(
                width: (widget.radius * 2) - 8,
                height: (widget.radius * 2) - 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    placeholder: widget.placeholder,
                    errorWidget: widget.errorWidget,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Render the pulsing circle on top
            Transform.scale(
              scale: _pulseScaleAnimation.value,
              child: Container(
                width: (widget.radius * 2) - 8,
                height: (widget.radius * 2) - 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.pulseColor.withOpacity(
                    _pulseController.isAnimating ? _pulseOpacityAnimation.value : 0.0,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
