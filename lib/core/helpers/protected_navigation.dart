import 'package:flutter/material.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

class ProtectedNavigation {
  ProtectedNavigation._();

  // =====================================================
  // OPEN NOTIFICATIONS
  // =====================================================

  static void openNotifications(
      BuildContext context,
      ) {
    if (GuestSession.isGuest) {
      LoginRequiredDialog.show(context);
      return;
    }

    // TODO: NotificationScreen removed - re-implement when available
    // Navigator.pushNamed(
    //   context,
    //   AppRoutes.notifications,
    // );
  }

  // =====================================================
  // OPEN PROFILE
  // =====================================================

  static void openProfile(
      BuildContext context,
      ) {
    if (GuestSession.isGuest) {
      LoginRequiredDialog.show(context);
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.profile,
    );
  }
}