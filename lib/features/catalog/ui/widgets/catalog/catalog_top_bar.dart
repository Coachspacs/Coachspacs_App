import 'package:flutter/material.dart';

class CatalogTopBar extends StatelessWidget {
  const CatalogTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2EBE8),
          ),
        ),
      ),
      child: Row(
        children: [
          // Logo + Coach Space
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F5F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
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
                        color: Color(0xFF075E4D),
                        size: 20,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 9),

              const Text(
                'Coach Space',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF073F38),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Notifications
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF263C38),
              size: 22,
            ),
          ),

          const SizedBox(width: 6),

          // User Avatar
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFE7F5F0),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              'h',
              style: TextStyle(
                color: Color(0xFF075E4D),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}