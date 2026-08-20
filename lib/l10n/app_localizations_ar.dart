// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'كوتش سبيس';

  @override
  String get homeSearchHint => 'ابحث عن دورات، مدربين...';

  @override
  String get homeAll => 'الكل';

  @override
  String get homeFeatured => 'دورات مميزة';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeTrending => 'رائج الآن';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navCourses => 'الدورات';

  @override
  String get navSearch => 'بحث';

  @override
  String get navProfile => 'حسابي';

  @override
  String get homeEmptyTitle => 'لا توجد محتويات';

  @override
  String get homeEmptySubtitle => 'لم يتم العثور على أي دورات حالياً';

  @override
  String get homeErrorTitle => 'حدث خطأ';

  @override
  String get homeErrorSubtitle =>
      'حدث خطأ أثناء تحميل البيانات. يرجى المحاولة مرة أخرى.';

  @override
  String get homeOfflineTitle => 'لا يوجد اتصال';

  @override
  String get homeOfflineSubtitle =>
      'يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى';

  @override
  String get homeRetry => 'إعادة المحاولة';

  @override
  String get loginWelcome => 'مرحباً بعودتك';

  @override
  String get loginEmailLabel => 'البريد الإلكتروني';

  @override
  String get loginPasswordLabel => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginButtonLoading => 'جاري الدخول...';

  @override
  String get loginForgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get loginNoAccount => 'ليس لديك حساب؟ ';

  @override
  String get loginRegister => 'إنشاء حساب';

  @override
  String get signupTitle => 'انضم إلى مستقبل\nالتعلم';

  @override
  String get signupNameLabel => 'الاسم الكامل';

  @override
  String get signupNameHint => 'مثال: أحمد محمد';

  @override
  String get signupEmailLabel => 'البريد الإلكتروني';

  @override
  String get signupPasswordLabel => 'كلمة المرور';

  @override
  String get signupTermsAgree => 'أوافق على شروط الخدمة وسياسة الخصوصية';

  @override
  String get signupCreateAccount => 'إنشاء حساب';

  @override
  String get signupHasAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get signupLogin => 'تسجيل الدخول';

  @override
  String get signupValidationError => 'يرجى ملء جميع الحقول';

  @override
  String get signupTermsError => 'يجب الموافقة على شروط الخدمة';

  @override
  String get signupPendingApproval => 'حسابك بانتظار الموافقة من الإدارة';

  @override
  String get signupError => 'تعذر إنشاء الحساب';

  @override
  String get signupCreatingAccount => 'جاري إنشاء الحساب...';

  @override
  String get signupRoleLabel => 'أنا أنضم كـ';

  @override
  String get signupRoleStudent => 'طالب';

  @override
  String get signupRoleInstructor => 'مدرب';

  @override
  String get loginValidationError => 'أدخل البريد الإلكتروني وكلمة المرور';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني المرتبط بحسابك وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.';

  @override
  String get forgotPasswordEmailLabel => 'البريد الإلكتروني';

  @override
  String get forgotPasswordButton => 'إرسال رابط التحقق';

  @override
  String get forgotPasswordSending => 'جاري الإرسال...';

  @override
  String get forgotPasswordSuccess =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني';

  @override
  String get forgotPasswordEmailEmpty => 'أدخل البريد الإلكتروني';

  @override
  String get forgotPasswordBackToLogin => 'العودة لتسجيل الدخول';

  @override
  String get emailVerificationTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String get emailVerificationBodyPrefix => 'لقد أرسلنا رابط التحقق إلى ';

  @override
  String get emailVerificationBodySuffix =>
      '. اضغط على الرابط في بريدك الإلكتروني لتفعيل حسابك.';

  @override
  String get emailVerificationOpenEmail => 'فتح البريد الإلكتروني';

  @override
  String get emailVerificationOpenEmailHint =>
      'بعد الضغط على رابط التحقق، يمكنك تسجيل الدخول';

  @override
  String get emailVerificationNotReceived => 'لم يصلك الرابط؟';

  @override
  String get emailVerificationSending => 'جاري الإرسال...';

  @override
  String emailVerificationResendCountdown(String time) {
    return 'إعادة الإرسال ($time)';
  }

  @override
  String get emailVerificationResent => 'تم إعادة إرسال رابط التحقق';

  @override
  String get pendingApprovalTitle => 'بانتظار موافقة الإدارة';

  @override
  String get pendingApprovalSubtitle =>
      'تم استلام طلبك بنجاح. سيتم تفعيل حسابك المدربي بعد موافقة الإدارة. سنعلمك فور اكتمال المراجعة.';

  @override
  String get pendingApprovalLogout => 'تسجيل الخروج';
}
