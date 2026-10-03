import 'package:flutter/material.dart';

class MyPathHoursRoadmap extends StatelessWidget {
  const MyPathHoursRoadmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 208,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE3F6F2),
            Color(0xFFD4ECE4),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFD1ECE4),
        ),
      ),
      child: Stack(
        children: [
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
              text: 'Active Plan',
              dark: true,
            ),
          ),

          // Placeholder icon.
          // Later replace this whole area with the roadmap animation.
          const Center(
            child: Icon(
              Icons.alt_route_rounded,
              size: 42,
              color: Color(0xFF08715D),
            ),
          ),
        ],
      ),
    );
  }
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
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF17745D) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: dark
            ? null
            : Border.all(
          color: const Color(0xFFD5EDE5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: dark
                ? const Color(0xFFB9F0DB)
                : const Color(0xFF075E4D),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: dark
                  ? Colors.white
                  : const Color(0xFF075E4D),
            ),
          ),
        ],
      ),
    );
  }
}