import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/roadmap_dtos.dart';
import 'my_path_roadmap_palette.dart';

/// The vertical learning-rail canvas cloned from the web `block md:hidden`
/// layout: dotted paper background, a "Roadmap Start Line" pill, a glowing
/// gradient rail, numbered milestone badges and the goal pill at the bottom.
class MyPathRoadmapCanvas extends StatelessWidget {
  const MyPathRoadmapCanvas({
    super.key,
    required this.steps,
    required this.activeIndex,
    required this.expandedId,
    required this.cardBuilder,
    required this.activeBadgeLabel,
    required this.levelBadgeLabel,
    required this.youAreHereLabel,
    required this.startLineLabel,
    required this.goalPillLabel,
    required this.onRailTap,
  });

  final List<RoadmapStepDto> steps;

  /// Index (within [steps]) of the milestone the student should work on now.
  final int activeIndex;

  /// Id of the step whose card is expanded, or null for all collapsed.
  final String? expandedId;

  /// Builds the stage card (compact or expanded) for the row index.
  final MyPathCardBuilder cardBuilder;
  final String activeBadgeLabel;
  final String levelBadgeLabel;
  final String youAreHereLabel;
  final String startLineLabel;
  final String goalPillLabel;
  final ValueChanged<int> onRailTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyPathRoadmapColors.canvasTop,
            MyPathRoadmapColors.canvasMid,
            MyPathRoadmapColors.canvasBottom,
          ],
        ),
        border: Border.all(
          color: MyPathRoadmapColors.canvasBorder,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F7AE0B2),
            blurRadius: 36,
            offset: Offset(0, 12),
            spreadRadius: -6,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _PaperDotsPainter()),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: _StartLinePill(label: startLineLabel)),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Positioned(
                    left: 20,
                    top: 24,
                    bottom: 34,
                    width: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF34D399),
                            MyPathRoadmapColors.mint,
                            Color(0xFF0D9488),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x4D38E09D),
                            blurRadius: 10,
                            spreadRadius: -1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < steps.length; i++)
                        _RailRow(
                          step: steps[i],
                          index: i,
                          total: steps.length,
                          activeIndex: activeIndex,
                          expandedId: expandedId,
                          cardBuilder: cardBuilder,
                          activeBadgeLabel: activeBadgeLabel,
                          levelBadgeLabel: levelBadgeLabel,
                          youAreHereLabel: youAreHereLabel,
                          onRailTap: onRailTap,
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Center(child: _GoalPill(label: goalPillLabel)),
            ],
          ),
        ],
      ),
    );
  }
}

typedef MyPathCardBuilder = Widget Function(int index);

class _RailRow extends StatelessWidget {
  const _RailRow({
    required this.step,
    required this.index,
    required this.total,
    required this.activeIndex,
    required this.expandedId,
    required this.cardBuilder,
    required this.activeBadgeLabel,
    required this.levelBadgeLabel,
    required this.youAreHereLabel,
    required this.onRailTap,
  });

  final RoadmapStepDto step;
  final int index;
  final int total;
  final int activeIndex;
  final String? expandedId;
  final MyPathCardBuilder cardBuilder;
  final String activeBadgeLabel;
  final String levelBadgeLabel;
  final String youAreHereLabel;
  final ValueChanged<int> onRailTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RailBadge(
            step: step,
            index: index,
            isLast: index == total - 1,
            isCurrent: index == activeIndex,
            activeLabel: activeBadgeLabel,
            levelLabel: levelBadgeLabel,
            onTap: () => onRailTap(index),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (index == activeIndex) ...[
                  _YouAreHereBanner(label: youAreHereLabel),
                  const SizedBox(height: 8),
                ],
                cardBuilder(index),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// RAIL BADGE
// --------------------------------------------------------------------------
class _RailBadge extends StatefulWidget {
  const _RailBadge({
    required this.step,
    required this.index,
    required this.isLast,
    required this.isCurrent,
    required this.activeLabel,
    required this.levelLabel,
    required this.onTap,
  });

  final RoadmapStepDto step;
  final int index;
  final bool isLast;
  final bool isCurrent;
  final String activeLabel;
  final String levelLabel;
  final VoidCallback onTap;

  @override
  State<_RailBadge> createState() => _RailBadgeState();
}

class _RailBadgeState extends State<_RailBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    if (widget.isCurrent) _pulse.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant _RailBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrent && !_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    } else if (!widget.isCurrent && _pulse.isAnimating) {
      _pulse.stop();
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final done = widget.step.isCompleted;
    final skipped = widget.step.isSkipped;
    final isLast = widget.isLast && !done;

    Widget numberAndLabel() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _twoDigit(widget.index + 1),
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              height: 1,
              color: widget.isCurrent
                  ? Colors.white
                  : MyPathRoadmapColors.headerDarkMid,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.isCurrent
                ? widget.activeLabel.toUpperCase()
                : widget.levelLabel.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 7.5,
              fontWeight: FontWeight.w900,
              height: 1,
              letterSpacing: .5,
              color: widget.isCurrent
                  ? MyPathRoadmapColors.mint
                  : const Color(0xB31E8A73),
            ),
          ),
        ],
      );
    }

    final badge = AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        // The current badge breathes a little — an homage to the web ring.
        final scale =
            widget.isCurrent ? 1 + _pulse.value * .06 : 1.0;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: done
                    ? const [
                        MyPathRoadmapColors.badgeDoneTop,
                        MyPathRoadmapColors.headerDarkMid,
                      ]
                    : skipped
                        ? const [
                            MyPathRoadmapColors.badgeSkipped,
                            MyPathRoadmapColors.badgeSkipped,
                          ]
                        : isLast
                            ? const [
                                MyPathRoadmapColors.badgeLastTop,
                                MyPathRoadmapColors.badgeLastBottom,
                              ]
                            : widget.isCurrent
                                ? const [
                                    MyPathRoadmapColors.badgeCurrentTop,
                                    MyPathRoadmapColors.badgeCurrentMid,
                                    MyPathRoadmapColors.badgeCurrentBottom,
                                  ]
                                : const [
                                    MyPathRoadmapColors.badgePendingTop,
                                    MyPathRoadmapColors.badgePendingMid,
                                    MyPathRoadmapColors.badgePendingBottom,
                                  ],
              ),
              border: skipped
                  ? Border.all(color: const Color(0xFFCBD5E1), width: 2)
                  : Border.all(
                      color: done || isLast
                          ? MyPathRoadmapColors.mint.withValues(alpha: .6)
                          : widget.isCurrent
                              ? MyPathRoadmapColors.mint
                              : MyPathRoadmapColors.mint.withValues(alpha: .5),
                      width: 2,
                    ),
              boxShadow: [
                if (widget.isCurrent)
                  BoxShadow(
                    color: MyPathRoadmapColors.mint.withValues(alpha: .45),
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
              ],
            ),
            alignment: Alignment.center,
            child: done
                ? const Icon(
                    Icons.check_rounded,
                    size: 20,
                    color: Colors.white,
                  )
                : skipped
                    ? const Icon(
                        Icons.remove_rounded,
                        size: 18,
                        color: Color(0xFF94A3B8),
                      )
                    : isLast
                        ? const Icon(
                            Icons.emoji_events_rounded,
                            size: 20,
                            color: MyPathRoadmapColors.mint,
                          )
                        : numberAndLabel(),
          ),
        );
      },
    );

    return Semantics(
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkResponse(
          onTap: widget.onTap,
          radius: 30,
          splashColor: Colors.transparent,
          highlightShape: BoxShape.rectangle,
          child: badge,
        ),
      ),
    );
  }
}

String _twoDigit(int n) => n < 10 ? '0$n' : '$n';

// --------------------------------------------------------------------------
// "YOU ARE HERE" BANNER + ROBOT MASCOT
// --------------------------------------------------------------------------
class _YouAreHereBanner extends StatefulWidget {
  const _YouAreHereBanner({required this.label});

  final String label;

  @override
  State<_YouAreHereBanner> createState() => _YouAreHereBannerState();
}

class _YouAreHereBannerState extends State<_YouAreHereBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xE6D1FAE5), Color(0xFFF0FDFA)],
        ),
        border: Border.all(color: MyPathRoadmapColors.badgePendingMid),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 42,
            child: AnimatedBuilder(
              animation: _float,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -3 + _float.value * 3),
                  child: Transform.rotate(
                    angle: math.sin(_float.value * math.pi) * .05,
                    child: RepaintBoundary(
                      child: CustomPaint(
                        size: const Size(64, 92),
                        painter: _RobotPainter(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF062E24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RobotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 160;
    canvas.scale(scale, scale);

    final mint = Paint()..color = MyPathRoadmapColors.mint;
    final white = Paint()..color = Colors.white;
    final dark = Paint()..color = const Color(0xFF1E293B);
    final borderSlate = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;

    // Graduation cap.
    final capPath = Path()
      ..moveTo(80, 36)
      ..lineTo(126, 50)
      ..lineTo(80, 64)
      ..lineTo(34, 50)
      ..close();
    canvas.drawPath(capPath, dark);
    canvas.drawPath(
      capPath,
      Paint()
        ..color = const Color(0xFF334155)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    //.constraint antenna ball
    canvas.drawCircle(const Offset(80, 26), 4, mint);
    canvas.drawLine(
      const Offset(80, 30),
      const Offset(80, 38),
      Paint()
        ..color = MyPathRoadmapColors.mint
        ..strokeWidth = 2,
    );

    // Head.
    final headRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(42, 62, 76, 62),
      const Radius.circular(28),
    );
    canvas.drawRRect(headRect, white);
    canvas.drawRRect(headRect, borderSlate);

    // Ears.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(36, 80, 8, 24),
        const Radius.circular(4),
      ),
      mint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(116, 80, 8, 24),
        const Radius.circular(4),
      ),
      mint,
    );

    // Visor.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(50, 72, 60, 42),
        const Radius.circular(16),
      ),
      dark,
    );

    // Eyes + smile.
    final face = Paint()
      ..color = MyPathRoadmapColors.mint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      const Rect.fromLTWH(58, 84, 12, 12),
      math.pi,
      math.pi,
      false,
      face,
    );
    canvas.drawArc(
      const Rect.fromLTWH(90, 84, 12, 12),
      math.pi,
      math.pi,
      false,
      face,
    );
    final smile = Paint()
      ..color = MyPathRoadmapColors.mint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      const Rect.fromLTWH(72, 92, 16, 14),
      .15,
      math.pi - .3,
      false,
      smile,
    );

    // Soft shadow blob under the bot.
    canvas.drawOval(
      const Rect.fromLTWH(45, 185, 70, 14),
      Paint()..color = const Color(0xFFA7F3D0).withValues(alpha: .5),
    );
  }

  @override
  bool shouldRepaint(covariant _RobotPainter oldDelegate) => false;
}

// --------------------------------------------------------------------------
// START / GOAL PILLS
// --------------------------------------------------------------------------
class _StartLinePill extends StatelessWidget {
  const _StartLinePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: MyPathRoadmapColors.headerDarkMid.withValues(alpha: .25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.flag_outlined,
            size: 14,
            color: Color(0xFF34D399),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF065F46),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalPill extends StatelessWidget {
  const _GoalPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyPathRoadmapColors.headerDarkMid.withValues(alpha: .96),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: MyPathRoadmapColors.mint.withValues(alpha: .4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33105244),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.emoji_events_rounded,
            size: 14,
            color: MyPathRoadmapColors.mint,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaperDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 24.0;
    final paint = Paint()
      ..color = MyPathRoadmapColors.canvasDot.withValues(alpha: .25)
      ..style = PaintingStyle.fill;
    for (var x = spacing / 2; x < size.width; x += spacing) {
      for (var y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PaperDotsPainter oldDelegate) => false;
}
