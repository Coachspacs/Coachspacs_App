import 'package:flutter/material.dart';

class TopAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const TopAppBarWidget({
    super.key,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5F0),
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Logo_img.png',
                fit: BoxFit.contain,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return const Icon(
                    Icons.auto_awesome,
                    size: 19,
                    color: Color(0xFF075E4D),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Coach Space',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF073F38),
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin:
          const EdgeInsets.only(right: 8),
          padding:
          const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD9E4E1),
            ),
          ),
          child: const Text(
            'EN',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: Color(0xFF53645F),
            ),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          margin:
          const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFE4F5F0),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'h',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF075E4D),
            ),
          ),
        ),
      ],
    );
  }
}