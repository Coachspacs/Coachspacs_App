import 'dart:math' as math;
import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';

import 'my_path_palette.dart';

/// Parametric positions (0..1 along the path) of the wizard waypoints.
const List<double> _waypointTs = [0.03, 0.35, 0.67];

/// Where the traveling marker halts for each step:
/// step 0 → start of the road, steps 1–3 → waypoints 1–3, step 4 → finish.
double _roadmapStopForStep(int step) {
  if (step <= 0) return 0;
  if (step > _waypointTs.length) return 1;
  return _waypointTs[step - 1];
}

/// Animated roadmap that draws the learning path from start to finish.
///
/// The road is painted progressively (0 → 1 [progress]), a glowing marker
/// travels along it, waypoints pop in as the path reaches them and the
/// finish flag pulses once the path is complete.
class MyPathAnimatedRoadmap extends StatefulWidget {
  const MyPathAnimatedRoadmap({
    super.key,
    required this.labels,
    this.currentStep = 0,
    this.height = 210,
    this.trailingBadge = 'Active Plan',
    this.showBadges = true,
  });

  /// Labels of the wizard steps, rendered under each waypoint.
  final List<String> labels;

  /// Index of the step the user is currently on (0-based).
  final int currentStep;

  final double height;
  final String trailingBadge;
  final bool showBadges;

  @override
  State<MyPathAnimatedRoadmap> createState() => _MyPathAnimatedRoadmapState();
}

class _MyPathAnimatedRoadmapState extends State<MyPathAnimatedRoadmap>
    with TickerProviderStateMixin {
  late final AnimationController _drawController;
  late final AnimationController _pulseController;
  late final AnimationController _shimmerController;
  late final Animation<double> _drawAnimation;

  double _from = 0;
  double _to = 0;

  /// Current drawn position on the path — the animation curve is 0..1 and
  /// must be interpolated between the start and target stops, otherwise the
  /// road would always end at path length 1.
  double get _visualProgress => _from + (_to - _from) * _drawAnimation.value;

  @override
  void initState() {
    super.initState();
    _drawController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
    _drawAnimation = CurvedAnimation(
      parent: _drawController,
      curve: Curves.easeOutCubic,
    );
    _to = _roadmapStopForStep(widget.currentStep);
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateTo());
  }

  @override
  void didUpdateWidget(covariant MyPathAnimatedRoadmap oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldStop = _roadmapStopForStep(oldWidget.currentStep);
    final newStop = _roadmapStopForStep(widget.currentStep);
    if (oldStop != newStop) {
      _from = _visualProgress;
      _to = newStop;
      _animateTo();
    } else if (oldWidget.currentStep != widget.currentStep ||
        oldWidget.trailingBadge != widget.trailingBadge) {
      setState(() {});
    }
  }

  void _animateTo() {
    final delta = (_to - _from).abs();
    _drawController.duration = Duration(
      milliseconds: (400 + delta * 1800).round(),
    );
    _drawController
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _drawController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _drawAnimation,
        _pulseController,
        _shimmerController,
      ]),
      builder: (context, _) {
        return Container(
          width: double.infinity,
          height: widget.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE5F7F1), Color(0xFFCFEADF)],
            ),
            border: Border.all(color: MyPathColors.cardBorder),
          ),
          child: Stack(
            children: [
              if (widget.showBadges) ...[
                Positioned(
                  top: 14,
                  left: 14,
                  child: _RoadmapBadge(
                    icon: Icons.auto_awesome,
                    text: 'AI Guided Roadmap',
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: _RoadmapBadge(
                    icon: Icons.circle,
                    text: widget.trailingBadge,
                    dark: true,
                  ),
                ),
              ],

              // Background hills
              Positioned(
                left: -30,
                right: -30,
                bottom: 35,
                child: Container(
                  height: 75,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(100),
                    ),
                    color: Color(0xFF7FC09F),
                  ),
                ),
              ),
              Positioned(
                left: -40,
                right: -40,
                bottom: -10,
                child: Container(
                  height: 75,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(100),
                    ),
                    color: Color(0xFF3E9671),
                  ),
                ),
              ),

              // Animated road
              Positioned(
                left: 34,
                right: 48,
                top: widget.showBadges ? 46 : 16,
                bottom: 34,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _AnimatedRoadPainter(
                    progress: _visualProgress,
                    pulse: _pulseController.value,
                    shimmer: _shimmerController.value,
                    labels: widget.labels,
                    currentStep: widget.currentStep,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedRoadPainter extends CustomPainter {
  _AnimatedRoadPainter({
    required this.progress,
    required this.pulse,
    required this.labels,
    required this.currentStep,
    required this.shimmer,
  });

  final double progress;
  final double pulse;
  final double shimmer;
  final List<String> labels;
  final int currentStep;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..cubicTo(
        size.width * .18,
        size.height * .15,
        size.width * .40,
        size.height * .85,
        size.width * .58,
        size.height * .40,
      )
      ..cubicTo(
        size.width * .72,
        size.height * .05,
        size.width * .83,
        size.height * .35,
        size.width,
        0,
      );

    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final clamped = progress.clamp(0.0, 1.0);

    // Untraveled part — soft white.
    final remaining = metric.extractPath(metric.length * clamped, metric.length);
    canvas.drawPath(
      remaining,
      Paint()
        ..color = Colors.white.withValues(alpha: .55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9
        ..strokeCap = StrokeCap.round,
    );

    // Traveled part — solid white.
    final traveled = metric.extractPath(0, metric.length * clamped);
    canvas.drawPath(
      traveled,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9
        ..strokeCap = StrokeCap.round,
    );
    // Center dashes on the traveled part, with a shimmer flowing ahead of
    // the marker so the road feels alive while it draws.
    _drawDashes(canvas, traveled, shimmer: pulse);

    // Waypoints.
    for (var i = 0; i < _waypointTs.length; i++) {
      _paintWaypoint(
        canvas,
        metric,
        _waypointTs[i],
        index: i,
      );
    }

    // Finish flag — travels with the road head and rests on the current
    // step's station; it only celebrates once the final stop is reached.
    _paintFinish(
      canvas,
      metric,
      clamped,
      arrived: _roadmapStopForStep(currentStep) > 0.99,
    );
  }

  void _drawDashes(Canvas canvas, Path traveled, {required double shimmer}) {
    for (final metric in traveled.computeMetrics()) {
      final dashLen = 7.0;
      final gap = 8.0;
      // A brightness wave travels along the dashes — the road "breathes"
      // in the direction of travel without moving the dashes themselves.
      final total = metric.length;
      var dist = 0.0;
      while (dist < total) {
        final end = math.min(dist + dashLen, total);
        final center = (dist + dashLen / 2) / total;
        final wave = math.sin((center - shimmer) * math.pi * 6);
        // wave ∈ [-1, 1] keeps alpha within [.1, 1] — no clamping needed.
        final alpha = 0.55 + wave * 0.45;
        canvas.drawPath(
          metric.extractPath(dist, end),
          Paint()
            ..color = MyPathColors.primary.withValues(alpha: alpha)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..strokeCap = StrokeCap.round,
        );
        dist += dashLen + gap;
      }
    }
  }

  void _paintWaypoint(
    Canvas canvas,
    PathMetric metric,
    double t, {
    required int index,
  }) {
    final done = index < currentStep || progress > t + 0.01;
    final active = index == currentStep && progress <= t + 0.01;
    // The station the user is heading to is shown right away so the next
    // target is visible even before the road reaches it.
    final appear = math.max(
      (progress / t).clamp(0.0, 1.0),
      active ? 1.0 : 0.0,
    );
    if (appear <= 0) return;

    final pos = metric.getTangentForOffset(metric.length * t)!.position;
    final pop = Curves.easeOutBack.transform(appear);
    final radius = 13.0 * pop;

    // Active pulse ring.
    if (active) {
      final ringRadius = radius + 4 + math.sin(pulse * math.pi * 2) * 3;
      canvas.drawCircle(
        pos,
        ringRadius,
        Paint()
          ..color = Colors.white.withValues(
            alpha: .5 + math.sin(pulse * math.pi * 2) * .3,
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }

    canvas.drawCircle(pos, radius, Paint()..color = Colors.white);
    canvas.drawCircle(
      pos,
      radius,
      Paint()
        ..color = done ? MyPathColors.primary : MyPathColors.primary.withValues(alpha: .18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    if (done) {
      // Check mark.
      final check = Path()
        ..moveTo(pos.dx - 5 * pop, pos.dy + 0.5)
        ..lineTo(pos.dx - 1.5 * pop, pos.dy + 4 * pop)
        ..lineTo(pos.dx + 5.5 * pop, pos.dy - 4 * pop);
      canvas.drawPath(
        check,
        Paint()
          ..color = MyPathColors.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    } else {
      final numberPainter = TextPainter(
        text: TextSpan(
          text: '${index + 1}',
          style: TextStyle(
            fontSize: 11 * pop,
            fontWeight: FontWeight.w800,
            color: MyPathColors.primary,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      numberPainter.paint(
        canvas,
        pos - Offset(numberPainter.width / 2, numberPainter.height / 2),
      );
    }

    // Label under the waypoint — fades up slightly after the pin pops.
    if (index < labels.length) {
      final labelAppear = Curves.easeOutCubic.transform(
        ((appear - 0.55) / 0.45).clamp(0.0, 1.0),
      );
      if (labelAppear > 0) {
        final tp = TextPainter(
          text: TextSpan(
            text: labels[index],
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2E6B5C).withValues(alpha: labelAppear),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(
          canvas,
          Offset(
            pos.dx - tp.width / 2,
            pos.dy + radius + 4 + (1 - labelAppear) * 4,
          ),
        );
      }
    }
  }

  void _paintFinish(
    Canvas canvas,
    PathMetric metric,
    double t, {
    required bool arrived,
  }) {
    final pos = metric.getTangentForOffset(metric.length * t)!.position;
    final pulseScale = arrived ? 1 + math.sin(pulse * math.pi * 2) * .12 : 1.0;

    // Ground glow.
    canvas.drawCircle(
      pos,
      16 * pulseScale,
      Paint()..color = Colors.white.withValues(alpha: arrived ? .9 : .7),
    );
    if (arrived) {
      canvas.drawCircle(
        pos,
        16 + 5 + math.sin(pulse * math.pi * 2) * 4,
        Paint()
          ..color = MyPathColors.amber.withValues(alpha: .55)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
    }

    // Flag pole.
    final polePaint = Paint()
      ..color = MyPathColors.primary
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(pos, pos - Offset(0, 20 * pulseScale), polePaint);

    // Flag — flutters on a sine wave, more when the journey is complete.
    final wave = math.sin(pulse * math.pi * 2) * (arrived ? 4 : 2.5);
    final tip = pos - Offset(0, 20 * pulseScale);
    final flag = Path()
      ..moveTo(tip.dx, tip.dy)
      ..quadraticBezierTo(
        tip.dx + 6.5 * pulseScale,
        tip.dy + (3.5 + wave * 0.6) * pulseScale,
        tip.dx + 13 * pulseScale,
        tip.dy + (3.5 + wave) * pulseScale,
      )
      ..quadraticBezierTo(
        tip.dx + 6.5 * pulseScale,
        tip.dy + (5.5 + wave * 0.6) * pulseScale,
        tip.dx,
        tip.dy + 8 * pulseScale,
      )
      ..close();
    canvas.drawPath(flag, Paint()..color = MyPathColors.amber);
  }

  @override
  bool shouldRepaint(covariant _AnimatedRoadPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.pulse != pulse ||
      oldDelegate.shimmer != shimmer ||
      oldDelegate.currentStep != currentStep ||
      oldDelegate.labels != labels;
}

class _RoadmapBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool dark;

  const _RoadmapBadge({
    required this.icon,
    required this.text,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF17745D) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: dark
            ? null
            : Border.all(color: const Color(0xFFD5EDE5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: dark ? const Color(0xFFB9F0DB) : MyPathColors.primary,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: dark ? Colors.white : MyPathColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
