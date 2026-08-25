import 'package:flutter/material.dart';

class TopAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const TopAppBarWidget({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

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
          // Coach Space Logo
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5F0),
              borderRadius: BorderRadius.circular(11),
            ),
            padding: const EdgeInsets.all(5),
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
                  size: 20,
                  color: Color(0xFF075E4D),
                );
              },
            ),
          ),

          const SizedBox(width: 9),

          Text(
            'Coach Space',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),

      actions: [
        // Language
        Container(
          margin: const EdgeInsets.only(
            right: 8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F8F7),
            borderRadius:
            BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFDCE7E4),
            ),
          ),
          child: Text(
            'EN',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF53645F),
            ),
          ),
        ),

        // Profile
        Container(
          width: 34,
          height: 34,
          margin: const EdgeInsets.only(
            right: 16,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFE4F5F0),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            'S',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),
      ],
    );
  }
}