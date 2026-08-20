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
import 'package:coach_space/features/profile/ui/screens/edit_profile_screen.dart';
import 'package:coach_space/features/profile/ui/screens/profile_screen.dart';

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
      case AppRoutes.editProfile:
        return _buildRoute(const EditProfileScreen(), settings);
      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen(), settings);
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
