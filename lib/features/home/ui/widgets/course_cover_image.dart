import 'package:flutter/material.dart';

class CourseCoverImage extends StatelessWidget {
  const CourseCoverImage({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();

    if (url == null || url.isEmpty) {
      return const _ImagePlaceholder();
    }

    return Image.network(
      url,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,

      // أثناء تحميل الصورة
      loadingBuilder: (
          context,
          child,
          loadingProgress,
          ) {
        if (loadingProgress == null) {
          return child;
        }

        return const _ImagePlaceholder(
          showLoading: true,
        );
      },

      // إذا الرابط غلط أو الـAPI رجع صورة مش موجودة
      errorBuilder: (
          context,
          error,
          stackTrace,
          ) {
        return const _ImagePlaceholder();
      },
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({
    this.showLoading = false,
  });

  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFEAF3F0),
      alignment: Alignment.center,
      child: showLoading
          ? const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xFF075E4D),
        ),
      )
          : const Icon(
        Icons.image_outlined,
        size: 32,
        color: Color(0xFF8AA09A),
      ),
    );
  }
}