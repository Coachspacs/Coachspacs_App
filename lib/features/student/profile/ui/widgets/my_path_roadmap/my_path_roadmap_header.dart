import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/widgets/fade_slide_in.dart';
import 'my_path_roadmap_palette.dart';

/// Dark hero card above the roadmap canvas — clone of the web header:
/// badges, plan title, completion %, actions and an animated progress bar.
class MyPathRoadmapHeader extends StatelessWidget {
  const MyPathRoadmapHeader({
    super.key,
    required this.completed,
    required this.total,
    required this.title,
    required this.headerBadge,
    required this.milestonesBadge,
    required this.progressLabel,
    required this.reorderLabel,
    required this.regenerateLabel,
    required this.onReorder,
    required this.onRegenerate,
  });

  final int completed;
  final int total;
  final String title;
  final String headerBadge;
  final String milestonesBadge;
  final String progressLabel;
  final String reorderLabel;
  final String regenerateLabel;
  final VoidCallback onReorder;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0 : (completed / total * 100).round();

    return FadeSlideIn(
      index: 0,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              MyPathRoadmapColors.headerDarkTop,
              MyPathRoadmapColors.headerDarkMid,
              MyPathRoadmapColors.headerDarkBottom,
            ],
          ),
          border: Border.all(color: MyPathRoadmapColors.headerBorder),
          boxShadow: const [
            BoxShadow(
              color: Color(0x59105244),
              blurRadius: 36,
              offset: Offset(0, 14),
              spreadRadius: -6,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            // Soft dot grid + glow orbs, mirroring the web decorations.
            const Positioned.fill(child: _DotGridOverlay(opacity: .08)),
            Positioned(
              top: -48,
              right: -48,
              child: _GlowOrb(size: 256, color: Colors.white.withValues(alpha: .10)),
            ),
            Positioned(
              bottom: -48,
              left: -48,
              child: _GlowOrb(size: 256, color: const Color(0x1A5EEAD4)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _HeaderChip(
                      icon: Icons.explore_outlined,
                      label: headerBadge,
                      background: Colors.white.withValues(alpha: .10),
                      border: Colors.white.withValues(alpha: .20),
                      color: MyPathRoadmapColors.headerTextSoft,
                    ),
                    _HeaderChip(
                      icon: Icons.auto_awesome,
                      label: milestonesBadge.replaceFirst(
                        '{count}',
                        '$total',
                      ),
                      background: Colors.white.withValues(alpha: .12),
                      border: MyPathRoadmapColors.mint.withValues(alpha: .55),
                      color: MyPathRoadmapColors.mint,
                      glow: true,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    letterSpacing: -0.3,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                Container(height: 1, color: Colors.white.withValues(alpha: .15)),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '$percent%',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: .4),
                        ),
                      ),
                    ),
                    Text(
                      progressLabel
                          .replaceFirst('{done}', '$completed')
                          .replaceFirst('{total}', '$total'),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0x99A7F3D0),
                      ),
                    ),
                    _PillAction(
                      label: reorderLabel,
                      icon: Icons.swap_vert_rounded,
                      iconColor: MyPathRoadmapColors.mint,
                      background: Colors.white.withValues(alpha: .10),
                      border: Colors.white.withValues(alpha: .20),
                      textColor: Colors.white,
                      onTap: onReorder,
                    ),
                    _PillAction(
                      label: regenerateLabel,
                      icon: Icons.refresh_rounded,
                      iconColor: MyPathRoadmapColors.headerDarkMid,
                      background: Colors.white,
                      border: Colors.transparent,
                      textColor: MyPathRoadmapColors.headerDarkMid,
                      onTap: onRegenerate,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _ProgressBar(percent: percent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Radial-gradient disc that reads as a blurred glow without paying for
/// a BackdropFilter.
class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({
    required this.icon,
    required this.label,
    required this.background,
    required this.border,
    required this.color,
    this.glow = false,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color border;
  final Color color;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: MyPathRoadmapColors.mint.withValues(alpha: .35),
                  blurRadius: 14,
                  spreadRadius: -1,
                ),
              ]
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _PillAction extends StatelessWidget {
  const _PillAction({
    required this.label,
    required this.icon,
    required this.background,
    required this.border,
    required this.textColor,
    required this.iconColor,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color border;
  final Color textColor;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.transparent,
        highlightColor: Colors.white.withValues(alpha: .08),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    final width = percent.clamp(0, 100) / 100;
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(2),
      height: 11,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .35),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: .15)),
      ),
      child: Stack(
        children: [
          AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            widthFactor: width,
            heightFactor: 1,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF10B981),
                    MyPathRoadmapColors.mint,
                    MyPathRoadmapColors.teal,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xA638E09D),
                    blurRadius: 14,
                    spreadRadius: -2,
                  ),
                ],
              ),
            ),
          ),
          const Positioned.fill(child: _ProgressBarShimmer()),
        ],
      ),
    );
  }
}

class _ProgressBarShimmer extends StatefulWidget {
  const _ProgressBarShimmer();

  @override
  State<_ProgressBarShimmer> createState() => _ProgressBarShimmerState();
}

class _ProgressBarShimmerState extends State<_ProgressBarShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
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
      builder: (context, _) {
        return IgnorePointer(
          child: Opacity(
            opacity: .35 + _controller.value * .3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1, 0),
                  end: Alignment(1, 0),
                  stops: [0.0, 0.5, 1.0],
                  colors: [Colors.transparent, Color(0x59FFFFFF), Colors.transparent],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DotGridOverlay extends StatelessWidget {
  const _DotGridOverlay({required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _DotGridPainter(opacity: opacity),
        size: Size.infinite,
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  _DotGridPainter({required this.opacity});

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 22.0;
    final paint = Paint()
      ..color = MyPathRoadmapColors.mint.withValues(alpha: opacity)
      ..style = PaintingStyle.fill;
    for (var x = 1.0; x < size.width; x += spacing) {
      for (var y = 1.0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.4, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
