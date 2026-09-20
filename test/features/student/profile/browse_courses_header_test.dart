import 'package:coach_space/features/student/profile/ui/widgets/browse_courses/browse_courses_header.dart';
import 'package:coach_space/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('reports the selected filter and changes it on tap', (
    tester,
  ) async {
    CourseFilter? changedFilter;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BrowseCoursesHeader(
            selectedStatus: CourseFilter.all,
            allCount: 3,
            inProgressCount: 2,
            completedCount: 1,
            onStatusChanged: (filter) => changedFilter = filter,
          ),
        ),
      ),
    );

    expect(
      tester.getSemantics(find.text('All (3)')),
      matchesSemantics(
        isSelected: true,
        hasSelectedState: true,
        isButton: true,
        isFocusable: true,
        hasTapAction: true,
        hasFocusAction: true,
      ),
    );

    await tester.tap(find.text('In Progress (2)'));
    expect(changedFilter, CourseFilter.inProgress);
  });
}
