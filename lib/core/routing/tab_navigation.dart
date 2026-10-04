import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/routes.dart';

/// Shared bottom-navigation behavior for instructor tab screens.
///
/// Keeps the index → route mapping in one place so every instructor screen
/// switches tabs identically (clearing the stack, as tab roots should).
abstract final class InstructorTabNavigation {
  /// Navigates to the tab at [index]:
  /// 0 → dashboard, 1 → courses, 2 → students, 3 → profile.
  ///
  /// The current tab is a no-op.
  static void handle(BuildContext context, int index) {
    switch (index) {
      case 0:
        _to(context, AppRoutes.instructorDashboard);
      case 1:
        _to(context, AppRoutes.instructorCourses);
      case 2:
        _to(context, AppRoutes.instructorStudents);
      case 3:
        _to(context, AppRoutes.instructorProfile);
    }
  }

  static void _to(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}
