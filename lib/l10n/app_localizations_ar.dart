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
  String get emailVerificationTitle => 'تمت إعادة إرسال البريد';

  @override
  String get emailVerificationBodyPrefix =>
      'لقد أرسلنا رابط تحقق جديداً إلى بريدك الإلكتروني. يرجى تفقد صندوق الوارد ومجلد الرسائل غير المرغوب فيها للمتابعة.';

  @override
  String get emailVerificationBodySuffix => '';

  @override
  String get emailVerificationOpenEmail => 'اذهب إلى البريد الوارد';

  @override
  String get emailVerificationOpenEmailHint =>
      'بعد الضغط على رابط التحقق، يمكنك تسجيل الدخول';

  @override
  String get emailVerificationNotReceived => 'لم يصلك الرابط؟';

  @override
  String get emailVerificationSending => 'جاري الإرسال...';

  @override
  String emailVerificationResendCountdown(String time) {
    return 'انتظر $time ثانية لإعادة الإرسال.';
  }

  @override
  String get emailVerificationResent => 'تم إعادة إرسال رابط التحقق';

  @override
  String get emailVerifiedSuccessTitle =>
      'تم التحقق من البريد الإلكتروني بنجاح!';

  @override
  String get emailVerifiedSuccessBody =>
      'تم تأكيد بريدك الإلكتروني. يمكنك الآن إكمال ملفك الشخصي وبدء رحلتك التدريبية.';

  @override
  String get emailVerifiedContinue => 'متابعة';

  @override
  String get emailAlreadyVerifiedTitle => 'تم التحقق مسبقاً';

  @override
  String get emailAlreadyVerifiedBody =>
      'تم التحقق من عنوان بريدك الإلكتروني مسبقاً. يمكنك تسجيل الدخول إلى حسابك مباشرةً.';

  @override
  String get emailAlreadyVerifiedSignIn => 'تسجيل الدخول الآن';

  @override
  String get pendingApprovalTitle => 'بانتظار موافقة الإدارة';

  @override
  String get pendingApprovalSubtitle =>
      'تم استلام طلبك بنجاح. سيتم تفعيل حسابك المدربي بعد موافقة الإدارة. سنعلمك فور اكتمال المراجعة.';

  @override
  String get pendingApprovalLogout => 'تسجيل الخروج';

  @override
  String get accountUnderReviewTitle => 'حسابك قيد المراجعة';

  @override
  String get accountUnderReviewSubtitle =>
      'شكراً لانضمامك إلى كوتش سبيس. فريقنا يراجع معلوماتك حالياً لضمان أعلى جودة لطلابنا. سنعلمك فور تفعيل حسابك.';

  @override
  String get accountUnderReviewContactSupport => 'التواصل مع الدعم';

  @override
  String get accountNotApprovedTitle => 'لم تتم الموافقة على الحساب';

  @override
  String get accountNotApprovedSubtitle =>
      'نأسف، لم تتم الموافقة على طلب انضمامك كمدرب من قبل الإدارة في الوقت الحالي.';

  @override
  String get accountNotApprovedReasonLabel => 'سبب الرفض:';

  @override
  String get accountNotApprovedDefaultReason =>
      'تعذر التحقق من الشهادات المهنية المرفقة. يرجى التأكد من وضوح المستندات وصلاحيتها.';

  @override
  String get accountNotApprovedNeedHelp => 'تحتاج مساعدة؟';

  @override
  String get accountNotApprovedHelpBody =>
      'إذا كنت تعتقد أن هذا خطأ أو ترغب في تقديم مستندات إضافية، يرجى التواصل مع فريق الدعم:';

  @override
  String get supportEmail => 'support@coachspace.com';

  @override
  String get accountNotApprovedSignOut => 'تسجيل الخروج';

  @override
  String get supportIntro =>
      'هل لديك سؤال أو تحتاج مساعدة؟ فريقنا هنا لمساعدتك على الاستفادة القصوى من رحلتك التدريبية.';

  @override
  String get supportSendMessageTitle => 'إرسال رسالة';

  @override
  String get supportMessageLabel => 'الرسالة';

  @override
  String get supportMessageHint => 'صف مشكلتك بالتفصيل...';

  @override
  String get supportSendButton => 'إرسال الرسالة';

  @override
  String get supportSending => 'جاري الإرسال...';

  @override
  String get supportCancel => 'إلغاء';

  @override
  String get supportMessageEmpty => 'يرجى إدخال الرسالة';

  @override
  String get supportMessageTooShort => 'الرسالة قصيرة جداً';

  @override
  String get supportMessageSent => 'تم إرسال الرسالة. سنعود إليك قريباً.';

  @override
  String get linkExpiredTitle => 'انتهت صلاحية الرابط';

  @override
  String get linkExpiredSubtitle =>
      'رابط التحقق الذي ضغطت عليه لم يعد صالحاً أو تم استخدامه مسبقاً. يرجى طلب رابط جديد للتحقق من حسابك.';

  @override
  String get linkExpiredResendButton => 'إعادة إرسال رابط التحقق';

  @override
  String get linkExpiredBackToLogin => 'العودة لتسجيل الدخول';

  @override
  String get linkExpiredNoEmail =>
      'لا يوجد بريد إلكتروني. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get settingsSaveSuccess => 'تم تحديث الملف الشخصي بنجاح.';

  @override
  String get settingsAvatarUpdated => 'تم تحديث الصورة الرمزية.';

  @override
  String get settingsEmailChangeSent =>
      'تم إرسال رسالة تأكيد إلى بريدك الجديد. يرجى التأكيد من صندوق الوارد.';

  @override
  String get settingsChangeEmailTitle => 'تغيير البريد الإلكتروني';

  @override
  String get settingsNewEmailLabel => 'البريد الجديد';

  @override
  String get settingsCancel => 'إلغاء';

  @override
  String get settingsSend => 'إرسال';

  @override
  String get settingsChange => 'تغيير';
}
