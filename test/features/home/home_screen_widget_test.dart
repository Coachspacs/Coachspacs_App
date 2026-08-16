import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/features/home/ui/screens/home_screen.dart';
import 'package:coach_space/features/home/ui/widgets/bottom_nav_bar_widget.dart';

Widget _arApp({required Widget home}) {
  return MaterialApp(locale: const Locale('ar'), home: home);
}

/// Reads the pill background of a bottom-nav item from its AnimatedContainer.
Color? _navItemSurfaceColor(WidgetTester tester, Finder label) {
  final container = tester.widget<AnimatedContainer>(
    find.ancestor(of: label, matching: find.byType(AnimatedContainer)).first,
  );
  return (container.decoration as BoxDecoration?)?.color;
}

void main() {
  setUpAll(setupLocator);

  group('BottomNavBarWidget', () {
    testWidgets('Home tab (الرئيسية) is the active pill on the home screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _arApp(
          home: const Scaffold(
            body: SizedBox(),
            bottomNavigationBar: BottomNavBarWidget(),
          ),
        ),
      );

      final homeColor = _navItemSurfaceColor(tester, find.text('الرئيسية'));
      final searchColor = _navItemSurfaceColor(tester, find.text('بحث'));

      expect(homeColor, isNot(Colors.transparent));
      expect(searchColor, Colors.transparent);
    });
  });

  group('HomeScreen', () {
    testWidgets('renders localized Arabic content with RTL layout', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(800, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_arApp(home: const HomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('ابحث عن دورات، مدربين...'), findsOneWidget);
      expect(find.text('دورات مميزة'), findsOneWidget);
      expect(find.text('رائج الآن'), findsOneWidget);
      expect(find.text('الكل'), findsOneWidget);
      expect(find.text('الرئيسية'), findsOneWidget);

      final context = tester.element(find.byType(HomeScreen));
      expect(Directionality.of(context), TextDirection.rtl);
    });
  });
}
