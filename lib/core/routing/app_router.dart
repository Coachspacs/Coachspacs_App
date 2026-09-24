import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/routes.dart';

import 'package:coach_space/features/auth/ui/screens/account_not_approved_screen.dart';
import 'package:coach_space/features/auth/ui/screens/email_verification_screen.dart';
import 'package:coach_space/features/auth/ui/screens/email_verification_success_screen.dart';
import 'package:coach_space/features/auth/ui/screens/forgot_password_screen.dart';
import 'package:coach_space/features/auth/ui/screens/link_expired_screen.dart';
import 'package:coach_space/features/auth/ui/screens/login_screen.dart';
import 'package:coach_space/features/auth/ui/screens/pending_approval_screen.dart';
import 'package:coach_space/features/auth/ui/screens/reset_password_screen.dart';
import 'package:coach_space/features/auth/ui/screens/support_screen.dart';

import 'package:coach_space/features/onboarding/screens/onboarding_screen.dart';

import 'package:coach_space/features/student/home/ui/screens/home_screen.dart';

import 'package:coach_space/features/signup/presentation/screens/signup_screen.dart';

import 'package:coach_space/features/instructor/students/ui/screens/instructor_students_screen.dart';
import 'package:coach_space/features/splash/ui/screens/splash_screen.dart';

import 'package:coach_space/features/student/profile/ui/screens/profile_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/browse_courses_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/dashboard_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/cart_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/order_history_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/certificates_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/settings_screen.dart';
import 'package:coach_space/features/student/catalog/ui/screens/catalog_screen.dart';
import 'package:coach_space/features/student/catalog/ui/screens/course_details_screen.dart';

import 'package:coach_space/features/student/my_learning/ui/screens/my_learning_screen.dart';
import 'package:coach_space/features/student/my_learning/ui/screens/lesson_player_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/profile_information_screen.dart';
import 'package:coach_space/features/instructor/courses/ui/screens/create_course_screen.dart';
// import 'package:coach_space/features/student/profile/ui/screens/learning_settings_screen.dart';
import 'package:coach_space/features/student/profile/ui/screens/security_settings_screen.dart';
// import 'package:coach_space/features/student/profile/ui/screens/preferences_settings_screen.dart';
import 'package:coach_space/features/instructor/courses/ui/screens/instructor_courses_screen.dart';
import 'package:coach_space/features/instructor/profile/ui/screens/instructor_profile_screen.dart';
import 'package:coach_space/features/instructor/dashboard/ui/screens/instructor_dashboard_screen.dart';
// import 'package:coach_space/features/student/notifications/ui/screens/notification_screen.dart';
import 'package:coach_space/features/instructor/notifications/ui/screens/instructor_notifications_screen.dart';
import 'package:coach_space/features/instructor/courses/ui/screens/instructor_course_edit_screen.dart';
import 'package:coach_space/features/instructor/courses/ui/screens/instructor_course_management_screen.dart';
import 'package:coach_space/features/instructor/students/ui/screens/instructor_student_progress_screen.dart';

import '../../features/auth/data/models/user_role.dart';
import '../../features/student/profile/ui/screens/checkout_screen.dart';
// import '../../features/student/profile/ui/screens/contact_us_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // =====================================================
      // AUTH
      // =====================================================

      case AppRoutes.splash:
        return _buildRoute(const SplashScreen(), settings);

      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);

      case AppRoutes.signup:
        return _buildRoute(const SignupScreen(), settings);

      case AppRoutes.forgotPassword:
        return _buildRoute(const ForgotPasswordScreen(), settings);

      case AppRoutes.resetPassword:
        return _buildRoute(const ResetPasswordScreen(), settings);

      case AppRoutes.onboarding:
        return _buildRoute(const OnboardingScreen(), settings);

      case AppRoutes.emailVerification:
        return _buildRoute(
          EmailVerificationScreen(email: settings.arguments as String?),
          settings,
        );

      case AppRoutes.emailVerificationSuccess:
        return _buildRoute(
          EmailVerificationSuccessScreen(role: settings.arguments as UserRole),
          settings,
        );

      case AppRoutes.emailAlreadyVerified:
        return _buildRoute(const LoginScreen(), settings);

      case AppRoutes.pendingApproval:
        return _buildRoute(const PendingApprovalScreen(), settings);

      case AppRoutes.accountNotApproved:
        return _buildRoute(
          AccountNotApprovedScreen(
            rejectionReason: settings.arguments as String?,
          ),
          settings,
        );

      case AppRoutes.support:
        return _buildRoute(const SupportScreen(), settings);

      case AppRoutes.linkExpired:
        return _buildRoute(
          LinkExpiredScreen(email: settings.arguments as String?),
          settings,
        );

      // =====================================================
      // HOME
      // =====================================================

      case AppRoutes.home:
        return _buildRoute(const HomeScreen(), settings);

      // =====================================================
      // CATALOG
      // =====================================================

      case AppRoutes.catalog:
        return _buildRoute(const CatalogScreen(), settings);

      case AppRoutes.courseDetails:
        return _buildRoute(const CourseDetailsScreen(), settings);

      // =====================================================
      // MY LEARNING
      // =====================================================

      case AppRoutes.myLearning:
        return _buildRoute(const MyLearningScreen(), settings);

      case AppRoutes.lessonPlayer:
        return _buildRoute(const LessonPlayerScreen(), settings);

      // =====================================================
      // PROFILE
      // =====================================================

      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen(), settings);
      case AppRoutes.profileInformation:
        return _buildRoute(
          const ProfileInformationScreen(),
          settings,
        );

      // case AppRoutes.contactUs:
      //   return _buildRoute(
      //     const ContactUsScreen(),
      //     settings,
      //   );
      case AppRoutes.checkout:
        return _buildRoute(const CheckoutScreen(), settings);
      // =====================================================
      // INSTRUCTOR
      // =====================================================

      case AppRoutes.instructorDashboard:
        return _buildRoute(const InstructorDashboardScreen(), settings);

      case AppRoutes.instructorCourses:
        return _buildRoute(const InstructorCoursesScreen(), settings);

      case AppRoutes.instructorStudents:
        return _buildRoute(const InstructorStudentsScreen(), settings);

      case AppRoutes.instructorProfile:
        return _buildRoute(const InstructorProfileScreen(), settings);

      case AppRoutes.createInstructorCourse:
        return _buildRoute(const CreateCourseScreen(), settings);

      case AppRoutes.dashboard:
        return _buildRoute(const DashboardScreen(), settings);

      case AppRoutes.browseCourses:
        return _buildRoute(const BrowseCoursesScreen(), settings);

      case AppRoutes.cart:
        return _buildRoute(const CartScreen(), settings);

      case AppRoutes.orderHistory:
        return _buildRoute(const OrderHistoryScreen(), settings);

      case AppRoutes.certificates:
        return _buildRoute(const CertificatesScreen(), settings);

      case AppRoutes.accountSettings:
        return _buildRoute(const SettingsScreen(), settings);

      // case AppRoutes.learningSettings:
      //   return _buildRoute(const LearningSettingsScreen(), settings);

      case AppRoutes.securitySettings:
        return _buildRoute(const SecuritySettingsScreen(), settings);

      // case AppRoutes.preferencesSettings:
      //   return _buildRoute(const PreferencesSettingsScreen(), settings);

      // case AppRoutes.notifications:
      //   return _buildRoute(const NotificationScreen(), settings);

      case AppRoutes.instructorNotifications:
        return _buildRoute(const InstructorNotificationsScreen(), settings);

      case AppRoutes.instructorCourseEdit:
        return _buildRoute(
          InstructorCourseEditScreen(course: settings.arguments as dynamic),
          settings,
        );

      case AppRoutes.instructorCourseManagement:
        return _buildRoute(
          InstructorCourseManagementScreen(
            course: settings.arguments as InstructorCourse,
          ),
          settings,
        );

      case AppRoutes.instructorStudentProgress:
        return _buildRoute(
          InstructorStudentProgressScreen(student: settings.arguments as dynamic),
          settings,
        );

      default:
        return _buildRoute(const LoginScreen(), settings);
    }
  }

  Route<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
