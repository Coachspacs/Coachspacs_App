import 'package:flutter/material.dart';

/// Network course cover with graceful loading/error fallbacks.
class CourseCoverImage extends StatelessWidget {
  const CourseCoverImage({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final url = imageUrl;

    return Container(
      color: colorScheme.surfaceContainer,
      alignment: Alignment.center,
      child: url == null
          ? _FallbackIcon(icon: Icons.image_outlined, color: colorScheme.outline)
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _FallbackIcon(
                icon: Icons.broken_image_outlined,
                color: colorScheme.outline,
              ),
            ),
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: 28);
  }
}
