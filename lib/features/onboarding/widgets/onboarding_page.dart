import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.animation,
    required this.accentLabel,
  });

  final String title;
  final String description;
  final String animation;
  final String accentLabel;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late final AnimationController _motionController;
  late final AnimationController _entranceController;

  late final Animation<double> _entrance;
  late final Animation<double> _motion;
  late final Animation<double> _glow;
  late final Animation<double> _badgePulse;

  bool get _isLearn => widget.accentLabel == 'LEARN';
  bool get _isProgress => widget.accentLabel == 'PROGRESS';
  bool get _isAchieve => widget.accentLabel == 'ACHIEVE';

  @override
  void initState() {
    super.initState();

    // =========================================================
    // MAIN CONTINUOUS MOTION
    // =========================================================

    _motionController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: _isLearn
            ? 5
            : _isProgress
            ? 6
            : 7,
      ),
    );

    _motion = CurvedAnimation(
      parent: _motionController,
      curve: Curves.easeInOutSine,
    );

    _glow = CurvedAnimation(
      parent: _motionController,
      curve: Curves.easeInOut,
    );

    _badgePulse = CurvedAnimation(
      parent: _motionController,
      curve: Curves.easeInOut,
    );

    _motionController.repeat(reverse: true);

    // =========================================================
    // ENTRANCE ANIMATION
    // =========================================================

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    _entrance = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _motionController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  // ===========================================================
  // LOTTIE TRANSFORM
  // ===========================================================

  Matrix4 _animationTransform(double value) {
    final matrix = Matrix4.identity();

    if (_isLearn) {
      // Learn:
      // vertical floating + tiny rotation
      matrix.translate(
        0.0,
        -8 * value,
      );

      matrix.rotateZ(
        0.008 * math.sin(value * math.pi),
      );

      matrix.scale(
        1.0 + (0.018 * value),
      );
    } else if (_isProgress) {
      // Progress:
      // horizontal movement + subtle tilt
      matrix.translate(
        7 * value,
        -2 * value,
      );

      matrix.rotateZ(
        -0.012 * math.sin(value * math.pi),
      );

      matrix.scale(
        1.0 + (0.012 * value),
      );
    } else {
      // Achieve:
      // slower and calmer floating
      matrix.translate(
        0.0,
        -5 * value,
      );

      matrix.rotateZ(
        0.005 * math.sin(value * math.pi),
      );

      matrix.scale(
        1.0 + (0.015 * value),
      );
    }

    return matrix;
  }

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        20,
        24,
        10,
      ),
      child: Column(
        children: [
          const Spacer(),

          // =====================================================
          // ILLUSTRATION AREA
          // =====================================================

          SizedBox(
            width: 270,
            height: 270,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _motionController,
                _entranceController,
              ]),
              builder: (context, child) {
                final motionValue = _motion.value;
                final entranceValue = _entrance.value;

                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // =================================================
                    // AMBIENT GLOW
                    // =================================================

                    Transform.scale(
                      scale: 0.95 + (0.06 * _glow.value),
                      child: Container(
                        width: 225,
                        height: 225,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(
                            0xFFBFE9DC,
                          ).withValues(
                            alpha: 0.25 + (0.12 * _glow.value),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF75C7AE,
                              ).withValues(
                                alpha: 0.10 +
                                    (0.08 * _glow.value),
                              ),
                              blurRadius: 35,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // =================================================
                    // MAIN BACKGROUND CARD
                    // =================================================

                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFE7F5F0,
                        ),
                        borderRadius: BorderRadius.circular(36),
                      ),
                    ),

                    // =================================================
                    // INNER CIRCLE
                    // =================================================

                    Container(
                      width: 185,
                      height: 185,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFDDF3EB,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(
                              alpha: 0.45,
                            ),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),

                    // =================================================
                    // DECORATIVE PARTICLES
                    // =================================================

                    if (_isLearn) ...[
                      _buildParticle(
                        left: 28,
                        top: 62,
                        size: 6,
                        value: motionValue,
                        phase: 0,
                      ),
                      _buildParticle(
                        right: 38,
                        bottom: 55,
                        size: 4,
                        value: motionValue,
                        phase: 1.5,
                      ),
                      _buildParticle(
                        left: 58,
                        bottom: 30,
                        size: 3,
                        value: motionValue,
                        phase: 3,
                      ),
                    ],

                    if (_isProgress) ...[
                      _buildParticle(
                        left: 35,
                        top: 85,
                        size: 5,
                        value: motionValue,
                        phase: 1,
                      ),
                      _buildParticle(
                        right: 35,
                        top: 70,
                        size: 4,
                        value: motionValue,
                        phase: 2.5,
                      ),
                    ],

                    if (_isAchieve) ...[
                      _buildParticle(
                        left: 42,
                        top: 45,
                        size: 4,
                        value: motionValue,
                        phase: 0.5,
                      ),
                      _buildParticle(
                        right: 48,
                        bottom: 48,
                        size: 5,
                        value: motionValue,
                        phase: 2,
                      ),
                    ],

                    // =================================================
                    // MAIN LOTTIE ANIMATION
                    // =================================================

                    Transform.scale(
                      scale: 0.88 + (0.12 * entranceValue),
                      child: Opacity(
                        opacity: entranceValue,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: _animationTransform(
                            motionValue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Lottie.asset(
                              widget.animation,
                              fit: BoxFit.contain,
                              repeat: true,
                              animate: true,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // =================================================
                    // ACCENT BADGE
                    // =================================================

                    Positioned(
                      top: 28,
                      right: 30,
                      child: Opacity(
                        opacity: entranceValue,
                        child: Transform.translate(
                          offset: Offset(
                            _isProgress
                                ? 4 * _badgePulse.value
                                : 0,
                            _isProgress
                                ? 0
                                : -3 * _badgePulse.value,
                          ),
                          child: Transform.scale(
                            scale: 0.96 +
                                (0.04 * _badgePulse.value),
                            child: _buildBadge(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 34),

          // =====================================================
          // TITLE
          // =====================================================

          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 14),

          // =====================================================
          // DESCRIPTION
          // =====================================================

          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              height: 1.65,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF71807C),
            ),
          ),

          const Spacer(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ===========================================================
  // BADGE
  // ===========================================================

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF075E4D,
            ).withValues(
              alpha: 0.08,
            ),
            blurRadius: 14,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        widget.accentLabel,
        style: GoogleFonts.inter(
          fontSize: 7,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF075E4D),
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // ===========================================================
  // PARTICLE
  // ===========================================================

  Widget _buildParticle({
    required double value,
    required double phase,
    double? left,
    double? right,
    double? top,
    double? bottom,
    required double size,
  }) {
    final movement =
        math.sin(
          (value * math.pi) + phase,
        ) *
            5;

    final opacity =
        0.35 +
            (0.45 *
                ((math.sin(
                  (value * math.pi) + phase,
                ) +
                    1) /
                    2));

    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Transform.translate(
        offset: Offset(
          0,
          movement,
        ),
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Color(0xFF75BFA8),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}