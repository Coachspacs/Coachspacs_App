import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/onboarding_bottom_actions.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _pageController =
  PageController();

  int _currentPage = 0;

  final List<Widget> _pages = const [
    // ===========================================================
    // PAGE 1 - LEARN
    // ===========================================================

    OnboardingPage(
      title: 'Learn. Grow. Succeed.',
      description:
      'Discover courses designed to help you build real skills and reach your goals.',
      animation:
      'assets/animations/onboarding_learn.json',
      accentLabel: 'LEARN',
    ),

    // ===========================================================
    // PAGE 2 - PROGRESS
    // ===========================================================

    OnboardingPage(
      title: 'Learn at Your Own Pace',
      description:
      'Follow your courses, track your progress, and keep learning whenever you want.',
      animation:
      'assets/animations/onboarding_progress.json',
      accentLabel: 'PROGRESS',
    ),

    // ===========================================================
    // PAGE 3 - ACHIEVE
    // ===========================================================

    OnboardingPage(
      title: 'Turn Learning Into Progress',
      description:
      'Complete courses, earn certificates, and keep moving forward with Coach Space.',
      animation:
      'assets/animations/onboarding_achieve.json',
      accentLabel: 'ACHIEVE',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ===========================================================
  // NEXT
  // ===========================================================

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  // ===========================================================
  // SKIP / FINISH
  // ===========================================================

  void _finishOnboarding() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage =
        _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF9),
      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // LOGO / BRAND
            // =================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                14,
                20,
                0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 38,
                    height: 38,
                    child: Image.asset(
                      'assets/images/Logo_img.png',
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return const Icon(
                          Icons.auto_awesome,
                          color: Color(0xFF075E4D),
                          size: 20,
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 9),

                  Text(
                    'Coach Space',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // PAGES
            // =================================================

            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _pages,
              ),
            ),

            // =================================================
            // INDICATOR
            // =================================================

            OnboardingIndicator(
              currentIndex: _currentPage,
              itemCount: _pages.length,
            ),

            const SizedBox(height: 18),

            // =================================================
            // ACTIONS
            // =================================================

            OnboardingBottomActions(
              onSkip: _finishOnboarding,
              onNext: _nextPage,
              isLastPage: isLastPage,
            ),
          ],
        ),
      ),
    );
  }
}