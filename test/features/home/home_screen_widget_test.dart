import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/l10n/app_localizations.dart';

Widget _app({required Widget home}) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

Color? _navItemSurfaceColor(
    WidgetTester tester,
    Finder label,
    ) {
  final container = tester.widget<AnimatedContainer>(
    find
        .ancestor(
      of: label,
      matching: find.byType(AnimatedContainer),
    )
        .first,
  );

  return (container.decoration as BoxDecoration?)?.color;
}

void main() {
  group('BottomNavBarWidget', () {
    testWidgets(
      'Home tab is the active pill',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          _app(
            home: const Scaffold(
              body: SizedBox(),
              bottomNavigationBar: BottomNavBarWidget(
                currentIndex: 0,
              ),
            ),
          ),
        );

        final homeColor = _navItemSurfaceColor(
          tester,
          find.text('Home'),
        );

        final coursesColor = _navItemSurfaceColor(
          tester,
          find.text('Courses'),
        );

        expect(homeColor, isNot(Colors.transparent));
        expect(coursesColor, Colors.transparent);
      },
    );
  });
}