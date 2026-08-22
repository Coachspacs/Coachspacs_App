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

  @override
  String get signupRoleLabel => 'I AM JOINING AS';

  @override
  String get signupRoleStudent => 'Student';

  @override
  String get signupRoleInstructor => 'Instructor';

  @override
  String get loginValidationError => 'Enter your email and password';

  @override
  String get forgotPasswordTitle => 'Forgot your password?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter the email linked to your account and we\'ll send you a link to reset your password.';

  @override
  String get forgotPasswordEmailLabel => 'EMAIL ADDRESS';

  @override
  String get forgotPasswordButton => 'Send Reset Link';

  @override
  String get forgotPasswordSending => 'Sending...';

  @override
  String get forgotPasswordSuccess =>
      'A password reset link has been sent to your email';

  @override
  String get forgotPasswordEmailEmpty => 'Enter your email address';

  @override
  String get forgotPasswordBackToLogin => 'Back to login';

  @override
  String get emailVerificationTitle => 'Check your email';

  @override
  String get emailVerificationBodyPrefix =>
      'We\'ve sent a verification link to ';

  @override
  String get emailVerificationBodySuffix =>
      '. Click the link in your email to activate your account.';

  @override
  String get emailVerificationOpenEmail => 'Open Email';

  @override
  String get emailVerificationOpenEmailHint =>
      'After clicking the verification link, you can log in';

  @override
  String get emailVerificationNotReceived => 'Didn\'t get the link?';

  @override
  String get emailVerificationSending => 'Sending...';

  @override
  String emailVerificationResendCountdown(String time) {
    return 'Resend ($time)';
  }

  @override
  String get emailVerificationResent => 'Verification link sent again';

  @override
  String get pendingApprovalTitle => 'Pending Approval';

  @override
  String get pendingApprovalSubtitle =>
      'Your request has been received. Your instructor account will be activated once the admin approves it. We\'ll let you know as soon as the review is complete.';

  @override
  String get pendingApprovalLogout => 'Log Out';

  @override
  String get settingsSaveSuccess => 'Profile updated successfully.';

  @override
  String get settingsAvatarUpdated => 'Avatar updated.';

  @override
  String get settingsEmailChangeSent =>
      'Verification sent to your new email. Please confirm from your inbox.';

  @override
  String get settingsChangeEmailTitle => 'Change email';

  @override
  String get settingsNewEmailLabel => 'NEW EMAIL';

  @override
  String get settingsCancel => 'Cancel';

  @override
  String get settingsSend => 'Send';

  @override
  String get settingsChange => 'Change';
}
