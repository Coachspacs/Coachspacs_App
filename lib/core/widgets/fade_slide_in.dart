import 'package:flutter/material.dart';

/// Staggered entrance animation: fades, slides and settles (subtle scale)
/// its child in with a spring-like ease.
///
/// Pass an increasing [index] to create a stagger effect across siblings.
/// The stagger is driven by a real delay on the controller so the animation
/// stays interruptible — a rebuild mid-flight never snaps the child.
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.index = 0,
    this.offset = const Offset(0, 22),
    this.duration = const Duration(milliseconds: 520),
    this.delayStep = const Duration(milliseconds: 85),
  });

  final Widget child;

  /// Position of the widget among its siblings — 0 starts first.
  final int index;

  /// Where the child slides in from, in logical pixels.
  final Offset offset;

  final Duration duration;

  /// Extra delay added per unit of [index].
  final Duration delayStep;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _curve = CurvedAnimation(
      parent: _controller,
      // Spring-ish settle: overshoots a hair, then eases onto the target.
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInToLinear,
    );
    _fade = CurvedAnimation(
      parent: _controller,
      // Opacity overshooting looks wrong (clips), so use a plain ease-out.
      curve: Curves.easeOutCubic,
    );
    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(_curve);
    _scale = Tween<double>(begin: 0.97, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInToLinear,
      ),
    );

    // Real delay (not a bare Future) keeps the stagger on the same timeline
    // as the settle animation, and `mounted` guards dispose during the wait.
    final delay =
        Duration(milliseconds: widget.delayStep.inMilliseconds * widget.index);
    if (delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value,
          child: Transform.translate(
            offset: _slide.value,
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
