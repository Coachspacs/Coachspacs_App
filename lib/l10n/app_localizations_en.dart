// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Coach Space';

  @override
  String get homeSearchHint => 'Search for courses, trainers...';

  @override
  String get homeAll => 'All';

  @override
  String get homeFeatured => 'Featured Courses';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeTrending => 'Trending Now';

  @override
  String get navHome => 'Home';

  @override
  String get navCourses => 'Courses';

  @override
  String get navSearch => 'Search';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeEmptyTitle => 'No content available';

  @override
  String get homeEmptySubtitle => 'No courses found at the moment';

  @override
  String get homeErrorTitle => 'An error occurred';

  @override
  String get homeErrorSubtitle =>
      'An error occurred while loading data. Please try again.';

  @override
  String get homeOfflineTitle => 'No connection';

  @override
  String get homeOfflineSubtitle =>
      'Please check your internet connection and try again';

  @override
  String get homeRetry => 'Retry';

  @override
  String get loginWelcome => 'Welcome Back';

  @override
  String get loginEmailLabel => 'EMAIL ADDRESS';

  @override
  String get loginPasswordLabel => 'PASSWORD';

  @override
  String get loginButton => 'Login';

  @override
  String get loginButtonLoading => 'Logging in...';

  @override
  String get loginForgotPassword => 'Forgot Password?';

  @override
  String get loginNoAccount => 'Don\'t have an account? ';

  @override
  String get loginRegister => 'Register';

  @override
  String get signupTitle => 'Join the Future\nof Learning';

  @override
  String get signupNameLabel => 'FULL NAME';

  @override
  String get signupNameHint => 'Jane Doe';

  @override
  String get signupEmailLabel => 'EMAIL ADDRESS';

  @override
  String get signupPasswordLabel => 'PASSWORD';

  @override
  String get signupTermsAgree =>
      'I AGREE TO THE TERMS OF SERVICE AND PRIVACY POLICY';

  @override
  String get signupCreateAccount => 'Create Account';

  @override
  String get signupHasAccount => 'Already have an account? ';

  @override
  String get signupLogin => 'Log In';

  @override
  String get signupValidationError => 'Please fill in all fields';

  @override
  String get signupTermsError => 'You must agree to the terms of service';

  @override
  String get signupPendingApproval => 'Your account is pending admin approval';

  @override
  String get signupError => 'Failed to create account';

  @override
  String get signupCreatingAccount => 'Creating account...';
}
