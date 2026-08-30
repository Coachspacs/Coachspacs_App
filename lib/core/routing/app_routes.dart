/// Central registry of named application routes.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String emailVerification = '/email-verification';
  static const String emailVerificationSuccess =
      '/email-verification-success';
  static const String editProfile = '/edit-profile';

  // Profile
  static const String profile = '/profile';
  static const String dashboard = '/dashboard';
  static const String browseCourses = '/browse-courses';
  static const String cart = '/cart';
  static const String orderHistory = '/order-history';
  static const String certificates = '/certificates';
  static const String accountSettings = '/account-settings';

  // Account Settings Tabs
  static const String learningSettings = '/learning-settings';
  static const String securitySettings = '/security-settings';
  static const String preferencesSettings = '/preferences-settings';

  // Catalog
  static const String catalog = '/catalog';
  static const String courseDetails = '/course-details';

  // Home
  static const String home = '/home';

  // Instructor
  static const String instructorDashboard =
      '/instructor-dashboard';

  static const String instructorCourses =
      '/instructor-courses';


  static const String createInstructorCourse =
      '/instructor-create-course';


  // My Learning
  static const String myLearning = '/my-learning';

  static const String pendingApproval = '/pending-approval';
  static const String notifications = '/notifications';
}