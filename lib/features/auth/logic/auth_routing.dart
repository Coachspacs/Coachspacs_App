import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/features/auth/data/models/approval_status.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';

/// Resolves the destination route for a session based on role + approval.
///
/// Centralized so the splash/restore flow, the login screen, and the app-level
/// auth gate all route identically.
String routeForSession(UserSession session) {
  switch (session.role) {
    case UserRole.student:
      return AppRoutes.home;
    case UserRole.instructor:
      switch (session.approvalStatus) {
        case ApprovalStatus.approved:
          // No instructor dashboard exists yet — students and approved
          // instructors share the home screen (documented fallback).
          return AppRoutes.home;
        case ApprovalStatus.pending:
          return AppRoutes.pendingApproval;
        case ApprovalStatus.rejected:
          return AppRoutes.accountNotApproved;
        case ApprovalStatus.unknown:
          return AppRoutes.login;
      }
    case UserRole.admin:
      // No admin dashboard exists yet (documented fallback).
      return AppRoutes.home;
    case UserRole.unknown:
      return AppRoutes.login;
  }
}
