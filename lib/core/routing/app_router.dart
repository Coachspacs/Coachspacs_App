import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/features/auth/ui/screens/email_verification_screen.dart';
import 'package:coach_space/features/auth/ui/screens/email_verification_success_screen.dart';
import 'package:coach_space/features/auth/ui/screens/forgot_password_screen.dart';
import 'package:coach_space/features/auth/ui/screens/login_screen.dart';
import 'package:coach_space/features/auth/ui/screens/pending_approval_screen.dart';
import 'package:coach_space/features/home/ui/screens/home_screen.dart';
import 'package:coach_space/features/signup/presentation/screens/signup_screen.dart';
import 'package:coach_space/features/splash/ui/screens/splash_screen.dart';
import 'package:coach_space/features/profile/ui/screens/profile_screen.dart';
import 'package:coach_space/features/profile/ui/screens/browse_courses_screen.dart';
import 'package:coach_space/features/profile/ui/screens/dashboard_screen.dart';
import 'package:coach_space/features/profile/ui/screens/cart_screen.dart';
import 'package:coach_space/features/profile/ui/screens/order_history_screen.dart';
import 'package:coach_space/features/profile/ui/screens/certificates_screen.dart';


class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(const SplashScreen(), settings);
      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);
      case AppRoutes.signup:
        return _buildRoute(const SignupScreen(), settings);
      case AppRoutes.forgotPassword:
        return _buildRoute(const ForgotPasswordScreen(), settings);
      case AppRoutes.emailVerification:
        return _buildRoute(
          EmailVerificationScreen(email: settings.arguments as String?),
          settings,
        );
      case AppRoutes.emailVerificationSuccess:
        return _buildRoute(const EmailVerificationSuccessScreen(), settings);

      case AppRoutes.profile:
<<<<<<< HEAD
        return _buildRoute(const ProfileScreen(), settings);
=======
        return _buildRoute(
          const ProfileScreen(),
          settings,
        );
      case AppRoutes.dashboard:
        return _buildRoute(
          const DashboardScreen(),
          settings,
        );

      case AppRoutes.browseCourses:
        return _buildRoute(
          const BrowseCoursesScreen(),
          settings,
        );

      case AppRoutes.cart:
        return _buildRoute(
          const CartScreen(),
          settings,
        );

      case AppRoutes.orderHistory:
        return _buildRoute(
          const OrderHistoryScreen(),
          settings,
        );

      case AppRoutes.certificates:
        return _buildRoute(
          const CertificatesScreen(),
          settings,
        );

>>>>>>> 86e4d8e (Add order history and certificates screens)
      case AppRoutes.home:
        return _buildRoute(const HomeScreen(), settings);
      case AppRoutes.pendingApproval:
        return _buildRoute(const PendingApprovalScreen(), settings);
      default:
        return _buildRoute(const LoginScreen(), settings);
    }
  }

  Route<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
