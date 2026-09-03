import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';

class SettingsTabs extends StatelessWidget {
  const SettingsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute =
        ModalRoute.of(context)?.settings.name;

    final tabs = [
      _SettingsTabData(
        title: 'Profile',
        icon: Icons.person_outline_rounded,
        route: AppRoutes.accountSettings,
      ),
      _SettingsTabData(
        title: 'Learning & Certificates',
        icon: Icons.school_outlined,
        route: AppRoutes.learningSettings,
      ),
      _SettingsTabData(
        title: 'Security',
        icon: Icons.lock_outline_rounded,
        route: AppRoutes.securitySettings,
      ),
      _SettingsTabData(
        title: 'Preferences',
        icon: Icons.settings_outlined,
        route: AppRoutes.preferencesSettings,
      ),
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) =>
        const SizedBox(width: 7),
        itemBuilder: (context, index) {
          final tab = tabs[index];

          final isSelected =
              currentRoute == tab.route ||
                  (currentRoute == AppRoutes.accountSettings &&
                      tab.route == AppRoutes.accountSettings);

          return Material(
            color: isSelected
                ? const Color(0xFF0B624F)
                : const Color(0xFFF2F5F6),
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                if (currentRoute == tab.route) {
                  return;
                }

                Navigator.pushReplacementNamed(
                  context,
                  tab.route,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab.icon,
                      size: 15,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF687772),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tab.title,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF52615D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SettingsTabData {
  const _SettingsTabData({
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final String route;
}