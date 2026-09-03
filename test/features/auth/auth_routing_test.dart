import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/auth/data/models/approval_status.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';
import 'package:coach_space/features/auth/logic/auth_routing.dart';

UserSession session({
  UserRole role = UserRole.student,
  ApprovalStatus approvalStatus = ApprovalStatus.approved,
}) {
  return UserSession(
    access: 'access-1',
    refresh: 'refresh-1',
    role: role,
    approvalStatus: approvalStatus,
  );
}

void main() {
  group('routeForSession', () {
    test('student routes to home regardless of approval', () {
      expect(routeForSession(session()), AppRoutes.home);
      expect(
        routeForSession(session(approvalStatus: ApprovalStatus.pending)),
        AppRoutes.home,
      );
    });

    test('pending instructor routes to the pending-approval screen', () {
      expect(
        routeForSession(
          session(
            role: UserRole.instructor,
            approvalStatus: ApprovalStatus.pending,
          ),
        ),
        AppRoutes.pendingApproval,
      );
    });

    test('approved instructor routes to the instructor dashboard', () {
      expect(
        routeForSession(
          session(
            role: UserRole.instructor,
            approvalStatus: ApprovalStatus.approved,
          ),
        ),
        AppRoutes.instructorDashboard,
      );
    });

    test('rejected instructor is shown the account-not-approved screen', () {
      expect(
        routeForSession(
          session(
            role: UserRole.instructor,
            approvalStatus: ApprovalStatus.rejected,
          ),
        ),
        AppRoutes.accountNotApproved,
      );
    });

    test('admin falls back to home (no admin route yet)', () {
      expect(routeForSession(session(role: UserRole.admin)), AppRoutes.home);
    });

    test('unknown role is not granted any access', () {
      expect(
        routeForSession(
          session(
            role: UserRole.unknown,
            approvalStatus: ApprovalStatus.unknown,
          ),
        ),
        AppRoutes.login,
      );
    });
  });
}
