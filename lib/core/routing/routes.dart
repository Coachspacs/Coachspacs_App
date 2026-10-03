/// Central registry of named application routes.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String emailVerification = '/email-verification';
  static const String emailVerificationSuccess = '/email-verification-success';
  static const String emailAlreadyVerified = '/email-already-verified';
  static const String profileInformation = '/profile-information';
  static const String onboarding = '/onboarding';

  // Profile
  static const String profile = '/profile';
  static const String dashboard = '/dashboard';
  static const String browseCourses = '/browse-courses';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderHistory = '/order-history';
  static const String certificates = '/certificates';
  static const String accountSettings = '/account-settings';
  static const String contactUs = '/contact-us';
  static const String studentMyPath = '/student-my-path';
  static const String studentMyPathGoal = '/student-my-path-goal';
  static const String studentMyPathLevel = '/student-my-path-level';
  static const String studentMyPathSkill = '/student-my-path-skill';


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
  static const String instructorDashboard = '/instructor-dashboard';

  static const String instructorCourses = '/instructor-courses';

  static const String createInstructorCourse = '/instructor-create-course';

  static const String instructorStudents = '/instructor-students';

  static const String instructorProfile = '/instructor-profile';

  // Instructor screens (feature/student-app-ui)
  static const String instructorNotifications = '/instructor-notifications';
  static const String instructorCourseEdit = '/instructor-course-edit';
  static const String instructorCourseManagement = '/instructor-course-management';
  static const String instructorStudentProgress = '/instructor-student-progress';

  // My Learning
  static const String myLearning = '/my-learning';
  static const String lessonPlayer = '/lesson-player';

  static const String pendingApproval = '/pending-approval';
  static const String accountNotApproved = '/account-not-approved';
  static const String support = '/support';
  static const String linkExpired = '/link-expired';
  static const String notifications = '/notifications';
}
