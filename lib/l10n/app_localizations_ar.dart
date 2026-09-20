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

  @override
  String get courseDetailsLoading => 'جاري تحميل تفاصيل الدورة...';

  @override
  String get courseDetailsError => 'تعذر تحميل تفاصيل الدورة.';

  @override
  String get courseDetailsRetry => 'إعادة المحاولة';

  @override
  String get courseDetailsCurriculumEmpty => 'المنهج غير متاح حالياً.';

  @override
  String get courseDetailsAlreadyEnrolled => 'مسجل بالفعل';

  @override
  String get courseDetailsContinueLearning => 'تابع التعلم من حيث توقفت.';

  @override
  String get courseDetailsContinue => 'متابعة';

  @override
  String get courseDetailsEnrollFree => 'سجّل مجاناً';

  @override
  String get courseDetailsAddToCart => 'أضف إلى السلة';

  @override
  String get courseDetailsBuyNow => 'اشترِ الآن';

  @override
  String get courseDetailsAddedToCart => 'تمت الإضافة إلى السلة.';

  @override
  String get courseDetailsAddToCartConfirm => 'أضف إلى السلة؟';

  @override
  String get courseDetailsAddToCartMessage =>
      'هل تريد إضافة هذه الدورة إلى سلتك؟';

  @override
  String get courseDetailsCancel => 'إلغاء';

  @override
  String get courseDetailsYesAdd => 'نعم، أضفها';

  @override
  String get courseDetailsMoneyBack => 'ضمان استرداد الأموال لمدة 30 يوماً';

  @override
  String get courseDetailsIncludes => 'هذه الدورة تشمل';

  @override
  String get courseDetailsCurriculum => 'منهج الدورة';

  @override
  String get courseDetailsAboutInstructor => 'عن المدرب';

  @override
  String get catalogExplore => 'استكشف الدورات';

  @override
  String get catalogSubtitle => 'ابحث عن الدورة المناسبة لتطوير مهاراتك.';

  @override
  String get catalogAllCourses => 'جميع الدورات';

  @override
  String catalogCoursesCount(Object count) {
    return '$count دورة';
  }

  @override
  String get catalogNoCourses => 'لم يتم العثور على دورات';

  @override
  String get catalogTryAdjusting => 'حاول تعديل الفلاتر أو البحث.';

  @override
  String get catalogSort => 'ترتيب';

  @override
  String get catalogSortCourses => 'ترتيب الدورات';

  @override
  String get catalogNewest => 'الأحدث';

  @override
  String get catalogPriceLowHigh => 'السعر: من الأقل إلى الأعلى';

  @override
  String get catalogPriceHighLow => 'السعر: من الأعلى إلى الأقل';

  @override
  String get myLearningTitle => 'تعلمي';

  @override
  String get myLearningNoCourses => 'لا توجد دورات بعد';

  @override
  String get myLearningBrowseHint => 'تصفّح الكتالوج وسجّل في أول دورة لك.';

  @override
  String get myLearningBrowseCourses => 'تصفح الدورات';

  @override
  String get myLearningEnrolled => 'مسجل';

  @override
  String get myLearningInProgress => 'قيد التقدم';

  @override
  String get myLearningCompleted => 'مكتمل';

  @override
  String get myLearningContinueSection => 'تابع التعلم';

  @override
  String get myLearningCompletedSection => 'مكتملة';

  @override
  String get securityTitle => 'الأمان';

  @override
  String get securityCurrentPassword => 'كلمة المرور الحالية';

  @override
  String get securityNewPassword => 'كلمة المرور الجديدة';

  @override
  String get securityConfirmPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get securitySaveChanges => 'حفظ التغييرات';

  @override
  String get securityPasswordChanged => 'تم تغيير كلمة المرور بنجاح.';

  @override
  String get securityFillAllFields => 'يرجى ملء جميع الحقول.';

  @override
  String get securityPasswordsNoMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get profileInfoTitle => 'معلومات الملف الشخصي';

  @override
  String get profileInfoAvatar => 'الصورة الرمزية';

  @override
  String get profileInfoAvatarHint =>
      'ارفع صورة واضحة ليساعد الطلاب على التعرف عليك.';

  @override
  String get profileInfoAvatarFormat => 'JPG, PNG, WEBP حتى 5 ميغابايت.';

  @override
  String get profileInfoFullName => 'الاسم الكامل';

  @override
  String get profileInfoEmail => 'البريد الإلكتروني';

  @override
  String get profileInfoSaveChanges => 'حفظ التغييرات';

  @override
  String get profileInfoSaved => 'تم تحديث الملف الشخصي بنجاح.';

  @override
  String get profileInfoAvatarUpdated => 'تم تحديث الصورة الرمزية.';

  @override
  String get cartTitle => 'سلتي';

  @override
  String get cartEmpty => 'سلتك فارغة';

  @override
  String get cartEmptyHint => 'تصفّح الدورات وأضفها إلى سلتك.';

  @override
  String get checkoutTitle => 'إتمام الشراء';

  @override
  String get checkoutNoItems => 'لا توجد عناصر للشراء';

  @override
  String get checkoutNoItemsHint => 'أضف دورات إلى سلتك أولاً.';

  @override
  String get checkoutGoBack => 'رجوع';

  @override
  String get orderHistoryTitle => 'سجل الطلبات';

  @override
  String get orderHistoryEmpty => 'لا توجد طلبات بعد';

  @override
  String get orderHistoryEmptyHint => 'سيظهر سجل مشترياتك هنا.';

  @override
  String get certificatesTitle => 'الشهادات';

  @override
  String get certificatesEmpty => 'لا توجد شهادات بعد';

  @override
  String get certificatesEmptyHint => 'أكمل الدورات للحصول على شهادات.';

  @override
  String get contactUsTitle => 'تواصل معنا';

  @override
  String get contactUsIntro =>
      'هل لديك سؤال أو تحتاج مساعدة؟ فريقنا هنا لمساعدتك.';

  @override
  String get contactUsSendMessage => 'إرسال رسالة';

  @override
  String get contactUsMessageLabel => 'الرسالة';

  @override
  String get contactUsMessageHint => 'صف مشكلتك بالتفصيل...';

  @override
  String get contactUsSendButton => 'إرسال الرسالة';

  @override
  String get contactUsSent => 'تم إرسال الرسالة. سنعود إليك قريباً.';

  @override
  String get contactUsEmpty => 'يرجى إدخال الرسالة.';

  @override
  String get contactUsTooShort => 'الرسالة قصيرة جداً.';

  @override
  String get learningSettingsTitle => 'إعدادات التعلم';

  @override
  String get learningSettingsGoal => 'هدف التعلم';

  @override
  String get learningSettingsGoalHint => 'مثال: بناء مهارات عملية';

  @override
  String get learningSettingsField => 'مجال الاهتمام';

  @override
  String get learningSettingsFieldHint =>
      'مثال: علم البيانات والذكاء الاصطناعي';

  @override
  String get learningSettingsCertName => 'اسم الشهادة';

  @override
  String get learningSettingsCertHint => 'الاسم المطبوع على الشهادات';

  @override
  String get learningSettingsPlaybackSpeed => 'سرعة التشغيل';

  @override
  String get learningSettingsPublicProfile => 'الملف العام';

  @override
  String get learningSettingsPublicHint =>
      'السماح للآخرين برؤية دوراتك المسجلة.';

  @override
  String get learningSettingsSaved => 'تم حفظ إعدادات التعلم.';

  @override
  String get preferencesTitle => 'التفضيلات';

  @override
  String get preferencesEmailNotif => 'إشعارات البريد الإلكتروني';

  @override
  String get preferencesEmailNotifHint => 'استلام تحديثات الدورات عبر البريد.';

  @override
  String get preferencesPushNotif => 'الإشعارات الفورية';

  @override
  String get preferencesPushNotifHint => 'تنبيهات حول دورات جديدة وإنجازات.';

  @override
  String get preferencesLanguage => 'اللغة';

  @override
  String get preferencesTheme => 'المظهر';

  @override
  String get preferencesSaved => 'تم حفظ التفضيلات.';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDone => 'تم';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonError => 'حدث خطأ. حاول مرة أخرى.';

  @override
  String get errorOffline =>
      'لا يوجد اتصال بالإنترنت. تحقق من شبكتك وحاول مرة أخرى.';

  @override
  String get errorNotFound => 'العنصر المطلوب غير موجود.';

  @override
  String get errorServer => 'خطأ في الخادم. حاول مرة أخرى لاحقًا.';

  @override
  String get errorForbidden => 'غير مسموح لك بتنفيذ هذا الإجراء.';

  @override
  String get errorConflict => 'هذا الإجراء يتعارض مع الحالة الحالية.';

  @override
  String get errorRateLimited => 'محاولات كثيرة. انتظر لحظة من فضلك.';

  @override
  String get errorSessionExpired => 'انتهت جلستك. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get errorUnknown => 'حدث خطأ. حاول مرة أخرى.';

  @override
  String get catalogSearchHint => 'ابحث عن دورات...';

  @override
  String get catalogViewCourse => 'عرض الدورة';

  @override
  String get catalogFilters => 'التصفية';

  @override
  String get catalogFilterLanguage => 'اللغة';

  @override
  String get catalogFilterLevel => 'المستوى';

  @override
  String get catalogFilterPrice => 'السعر';

  @override
  String get catalogAllLevels => 'كل المستويات';

  @override
  String get catalogAllPrices => 'كل الأسعار';

  @override
  String get catalogFilterFree => 'مجاني';

  @override
  String get catalogUnder50 => 'أقل من 50\$';

  @override
  String get catalog50to100 => '50\$ - 100\$';

  @override
  String get catalog100plus => 'أكثر من 100\$';

  @override
  String get catalogApplyFilters => 'تطبيق التصفية';

  @override
  String get catalogResetFilters => 'مسح الكل';

  @override
  String get catalogResetAll => 'مسح الكل';

  @override
  String get catalogFilterEnglish => 'الإنجليزية';

  @override
  String get catalogFilterArabic => 'العربية';

  @override
  String get catalogLevelBeginner => 'مبتدئ';

  @override
  String get catalogLevelIntermediate => 'متوسط';

  @override
  String get catalogLevelAdvanced => 'متقدم';

  @override
  String get catalogLoadFailed => 'تعذر تحميل الدورات.';

  @override
  String get catalogFree => 'مجاني';

  @override
  String get courseDetailsTitle => 'تفاصيل الدورة';

  @override
  String get courseDetailsWatchPreview => 'مشاهدة المعاينة';

  @override
  String get courseDetailsPreviewTitle => 'معاينة الدورة';

  @override
  String get courseDetailsPreviewBody =>
      'هذه معاينة تعريفية للدورة. يمكنك مشاهدتها دون تسجيل الدخول.';

  @override
  String get courseDetailsClosePreview => 'إغلاق المعاينة';

  @override
  String get courseDetailsInstructorBio => 'مدرب متمرس ومربٍّ محترف.';

  @override
  String courseDetailsLessonsCount(Object count) {
    return '$count درس';
  }

  @override
  String courseDetailsTotalDuration(Object hours) {
    return '$hours ساعات من دروس الفيديو';
  }

  @override
  String get courseDetailsDownloadableResources => 'مصادر قابلة للتنزيل';

  @override
  String get courseDetailsProjects => 'مشاريع وتمارين عملية';

  @override
  String get courseDetailsLifetimeAccess => 'وصول مدى الحياة';

  @override
  String get courseDetailsCertificate => 'شهادة إتمام';

  @override
  String get courseDetailsAddToCartFailed => 'تعذرت إضافة الدورة إلى السلة.';

  @override
  String get courseDetailsLevel => 'المستوى';

  @override
  String get courseDetailsLanguage => 'اللغة';

  @override
  String get courseDetailsEnrollSuccess => 'تم التسجيل بنجاح.';

  @override
  String get courseDetailsEnrollFailed => 'تعذر التسجيل في هذه الدورة.';

  @override
  String get myLearningNoProgress => 'لا توجد دورات قيد التقدم بعد.';

  @override
  String get myLearningCourseCompleted => 'اكتملت الدورة';

  @override
  String get myLearningContinueWhereLeft => 'أكمل من حيث توقفت';

  @override
  String get myLearningMyCourses => 'دوراتي';

  @override
  String get myLearningViewAll => 'عرض الكل';

  @override
  String get myLearningCertificates => 'شهاداتي';

  @override
  String get myLearningCertificateEarned => 'شهادة مكتسبة';

  @override
  String get myLearningRecentActivity => 'النشاط الأخير';

  @override
  String get myLearningEnrolledLabel => 'مسجّل';

  @override
  String get myLearningCertificatesLabel => 'الشهادات';

  @override
  String get myLearningCourseSuffix => 'دورة';

  @override
  String get myLearningCoursesSuffix => 'دورات';

  @override
  String get myLearningEarned => 'مكتسبة';

  @override
  String get myLearningInProgressFooter => 'قيد التقدم';

  @override
  String myLearningActiveCount(Object count) {
    return '$count نشطة';
  }

  @override
  String get myLearningVerifiedCredential => '• اعتماد موثّق';

  @override
  String get myLearningAverageProgress => 'متوسط التقدم';

  @override
  String get myLearningLoadFailed => 'تعذر تحميل دوراتك.';

  @override
  String get myLearningNoCertificates => 'لا توجد شهادات بعد.';

  @override
  String get myLearningContinue => 'متابعة';

  @override
  String get lessonPlayerTitle => 'الدرس';

  @override
  String get lessonPlayerOpenVideo => 'فتح الفيديو';

  @override
  String get lessonPlayerMarkComplete => 'إكمال الدرس';

  @override
  String get lessonPlayerPrevious => 'السابق';

  @override
  String get lessonPlayerNext => 'التالي';

  @override
  String get dashboardEnrolledLabel => 'مسجّل';

  @override
  String get dashboardCertificatesLabel => 'الشهادات';

  @override
  String get dashboardAverageProgressLabel => 'متوسط التقدم';

  @override
  String get dashboardContinueLearning => 'متابعة التعلم';

  @override
  String get dashboardNoEnrollments => 'لم تسجّل في أي دورة بعد.';

  @override
  String get dashboardLoadFailed => 'تعذر تحميل لوحة التحكم.';

  @override
  String dashboardCoursesCount(Object count) {
    return '$count دورات';
  }

  @override
  String dashboardEarnedCount(Object count) {
    return '$count مكتسبة';
  }

  @override
  String get securityCurrentRequired => 'أدخل كلمة المرور الحالية.';

  @override
  String get securityNewRequired => 'أدخل كلمة المرور الجديدة.';

  @override
  String get securityConfirmRequired => 'أكد كلمة المرور الجديدة.';

  @override
  String get securityTooShort => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل.';

  @override
  String get securitySaveFailed => 'تعذر تغيير كلمة المرور.';

  @override
  String get profileStudent => 'طالب';

  @override
  String get profileInstructor => 'مدرب';

  @override
  String get profileSignOut => 'تسجيل الخروج';

  @override
  String get profileSignOutConfirm => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get profileAccountSettings => 'إعدادات الحساب';

  @override
  String get profileOrderHistory => 'سجل الطلبات';

  @override
  String get profileMyCart => 'سلتي';

  @override
  String get profileCertificates => 'الشهادات';

  @override
  String get profileContactUs => 'تواصل معنا';

  @override
  String get profileLoadFailed => 'تعذر تحميل ملفك الشخصي.';

  @override
  String get profileInfoChange => 'تغيير';

  @override
  String get profileInfoEmailNote =>
      'سيتم إرسال رابط تأكيد إلى العنوان الجديد.';

  @override
  String get profileInfoChangeEmail => 'تغيير البريد الإلكتروني';

  @override
  String get profileInfoNewEmail => 'البريد الإلكتروني الجديد';

  @override
  String get profileInfoEmailChangeSent =>
      'تم إرسال رابط التأكيد إلى بريدك الجديد.';

  @override
  String get profileInfoPhone => 'الهاتف';

  @override
  String get profileInfoHeadline => 'المسمى الوظيفي';

  @override
  String get profileInfoNameRequired => 'يرجى إدخال اسمك الكامل.';

  @override
  String get profileInfoLoadFailed => 'تعذر تحميل ملفك الشخصي.';

  @override
  String get profileInfoSaveFailed => 'تعذر حفظ ملفك الشخصي.';

  @override
  String get profileInfoAvatarFailed => 'تعذر رفع الصورة.';

  @override
  String get cartRemove => 'إزالة';

  @override
  String get cartRemoveConfirm => 'إزالة من السلة؟';

  @override
  String get cartRemoveConfirmMessage => 'هل تريد إزالة هذه الدورة من سلتك؟';

  @override
  String get cartRemoved => 'تمت إزالة العنصر من السلة.';

  @override
  String cartItemsCount(Object count) {
    return '$count عناصر';
  }

  @override
  String get cartSubtotal => 'المجموع الفرعي';

  @override
  String get cartDiscount => 'الخصم';

  @override
  String get cartTotal => 'الإجمالي';

  @override
  String get cartCheckout => 'إتمام الشراء';

  @override
  String get cartBrowseCourses => 'تصفح الدورات';

  @override
  String get cartLoadFailed => 'تعذر تحميل سلتك.';

  @override
  String get cartRemoveFailed => 'تعذرت إزالة العنصر.';

  @override
  String get cartAddFailed => 'تعذرت إضافة الدورة إلى السلة.';

  @override
  String get checkoutOrderSummary => 'ملخص الطلب';

  @override
  String get checkoutBillingInfo => 'معلومات الفاتورة';

  @override
  String get checkoutPaymentMethod => 'طريقة الدفع';

  @override
  String get checkoutPayWithCard => 'بطاقة ائتمان / خصم';

  @override
  String get checkoutPayManual => 'دفع يدوي (تجريبي)';

  @override
  String get checkoutManualHint => 'سيتم تعليم طلبك كمدفوع لأغراض التجربة.';

  @override
  String get checkoutFullName => 'الاسم الكامل';

  @override
  String get checkoutEmail => 'البريد الإلكتروني';

  @override
  String get checkoutCardNumber => 'رقم البطاقة';

  @override
  String get checkoutCardNumberHint => '0000 0000 0000 0000';

  @override
  String get checkoutExpiryDate => 'تاريخ الانتهاء';

  @override
  String get checkoutExpiryHint => 'MM/YY';

  @override
  String get checkoutCvv => 'CVV';

  @override
  String get checkoutCvvHint => '123';

  @override
  String get checkoutCardholder => 'اسم حامل البطاقة';

  @override
  String get checkoutCardholderHint => 'الاسم على البطاقة';

  @override
  String get checkoutCouponCode => 'كود الخصم';

  @override
  String get checkoutApply => 'تطبيق';

  @override
  String get checkoutCouponApplied => 'تم تطبيق الكود.';

  @override
  String get checkoutCouponInvalid => 'كود الخصم غير صالح.';

  @override
  String get checkoutSubtotal => 'المجموع الفرعي';

  @override
  String get checkoutDiscount => 'الخصم';

  @override
  String get checkoutTax => 'الضريبة';

  @override
  String get checkoutTotal => 'الإجمالي';

  @override
  String get checkoutPlaceOrder => 'تأكيد الطلب';

  @override
  String get checkoutProcessing => 'جارٍ المعالجة...';

  @override
  String get checkoutPaymentSuccess => 'تم الدفع بنجاح!';

  @override
  String get checkoutPaymentSuccessMessage => 'دوراتك متاحة الآن في \"تعلمي\".';

  @override
  String get checkoutViewOrders => 'عرض الطلبات';

  @override
  String get checkoutContinueShopping => 'متابعة التصفح';

  @override
  String get checkoutOrderFailed => 'تعذر إنشاء طلبك.';

  @override
  String get checkoutPaymentFailed => 'فشل الدفع. حاول مرة أخرى.';

  @override
  String get checkoutRequired => 'هذا الحقل مطلوب.';

  @override
  String get checkoutInvalidEmail => 'أدخل بريدًا إلكترونيًا صالحًا.';

  @override
  String get checkoutInvalidCard => 'أدخل رقم بطاقة صالحًا.';

  @override
  String get checkoutInvalidExpiry => 'أدخل تاريخ انتهاء صالحًا.';

  @override
  String get checkoutInvalidCvv => 'أدخل CVV صالحًا.';

  @override
  String get checkoutReadyForPayment => 'طلبك جاهز للدفع!';

  @override
  String get checkoutReadyForPaymentHint =>
      'ادفع بأمان عبر Stripe لتفعيل دوراتك.';

  @override
  String get checkoutOrderNumber => 'رقم الطلب';

  @override
  String get checkoutContinuePayment => 'متابعة الدفع';

  @override
  String get checkoutPaymentOpenFailed => 'تعذر فتح صفحة الدفع.';

  @override
  String get orderHistoryOrderNumber => 'الطلب';

  @override
  String get orderHistoryDate => 'التاريخ';

  @override
  String get orderHistoryItems => 'العناصر';

  @override
  String get orderHistoryTotal => 'الإجمالي';

  @override
  String get orderHistoryStatus => 'الحالة';

  @override
  String get orderHistoryStatusPending => 'قيد الانتظار';

  @override
  String get orderHistoryStatusPaid => 'مدفوع';

  @override
  String get orderHistoryStatusFailed => 'فشل';

  @override
  String get orderHistoryStatusRefunded => 'مسترد';

  @override
  String get orderHistoryStatusCancelled => 'ملغي';

  @override
  String get orderHistorySearchHint => 'ابحث في الطلبات...';

  @override
  String get orderHistoryLoadFailed => 'تعذر تحميل طلباتك.';

  @override
  String orderHistoryItemsCount(Object count) {
    return '$count عناصر';
  }

  @override
  String get certificatesIssuedOn => 'صدرت في';

  @override
  String get certificatesNumber => 'رقم الشهادة';

  @override
  String get certificatesDownload => 'تنزيل';

  @override
  String get certificatesDownloading => 'جارٍ التنزيل...';

  @override
  String get certificatesDownloaded => 'تم تنزيل الشهادة.';

  @override
  String get certificatesDownloadFailed => 'تعذر تنزيل الشهادة.';

  @override
  String get certificatesShare => 'مشاركة';

  @override
  String get certificatesLoadFailed => 'تعذر تحميل شهاداتك.';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsToday => 'اليوم';

  @override
  String get notificationsEarlier => 'سابقًا';

  @override
  String get notificationsEmpty => 'لا توجد إشعارات بعد';

  @override
  String get notificationsEmptyHint => 'ستظهر تحديثات دوراتك هنا.';

  @override
  String get notificationsMarkAllRead => 'تعليم الكل كمقروء';

  @override
  String get notificationsLoadFailed => 'تعذر تحميل الإشعارات.';

  @override
  String get notificationsMarkReadFailed => 'تعذر تحديث الإشعار.';

  @override
  String get learningSettingsLoadFailed => 'تعذر تحميل إعداداتك.';

  @override
  String get learningSettingsSaveFailed => 'تعذر حفظ إعداداتك.';

  @override
  String get preferencesLoadFailed => 'تعذر تحميل تفضيلاتك.';

  @override
  String get preferencesSaveFailed => 'تعذر حفظ تفضيلاتك.';

  @override
  String get preferencesEnglish => 'الإنجليزية';

  @override
  String get preferencesArabic => 'العربية';

  @override
  String get preferencesThemeLight => 'فاتح';

  @override
  String get preferencesThemeDark => 'داكن';

  @override
  String get preferencesThemeSystem => 'النظام';

  @override
  String get contactUsSubject => 'الموضوع';

  @override
  String get contactUsSubjectHint => 'كيف يمكننا مساعدتك؟';

  @override
  String get contactUsCategory => 'الفئة';

  @override
  String get contactUsCategoryGeneral => 'عام';

  @override
  String get contactUsCategoryTechnical => 'تقني';

  @override
  String get contactUsCategoryBilling => 'الفواتير';

  @override
  String get contactUsCategoryOther => 'أخرى';

  @override
  String get contactUsSendFailed => 'تعذر إرسال رسالتك.';

  @override
  String get homeContinueLearning => 'متابعة التعلم';

  @override
  String get homeCurrentModule => 'الوحدة الحالية';

  @override
  String get homeTopCategories => 'أهم التصنيفات';

  @override
  String get homeSeeAll => 'عرض الكل';

  @override
  String get homeRecommended => 'دورات مقترحة';

  @override
  String get homeRecommendedSubtitle => 'دورات مختارة لرحلتك التعليمية';

  @override
  String get homeWelcome => 'مرحبًا بعودتك';

  @override
  String get homeHeroTitle => 'اكتسب مهارات جديدة\nمع مدربين خبراء';

  @override
  String get homeResume => 'متابعة';

  @override
  String homeCompletedPercent(Object percent) {
    return '$percent% مكتمل';
  }

  @override
  String get homeNoContinue => 'ليس لديك أي دورة قيد التقدم.';

  @override
  String get homeViewCourse => 'عرض الدورة';

  @override
  String get settingsManageDescription =>
      'أدر تفضيلات حسابك وبياناتك الشخصية وتخصيص التطبيق من هنا.';

  @override
  String get settingsProfileInfoTitle => 'معلومات الملف الشخصي';

  @override
  String get settingsProfileInfoDescription =>
      'عدّل اسمك وصورتك الشخصية وبريدك الإلكتروني.';

  @override
  String get settingsLearningTitle => 'التعلم والشهادات';

  @override
  String get settingsLearningDescription =>
      'اسم مستلم الشهادة وهدف التعلم والمجال المهني.';

  @override
  String get settingsSecurityTitle => 'الأمان';

  @override
  String get settingsSecurityDescription => 'تحديث كلمة مرور حسابك.';

  @override
  String get settingsPreferencesTitle => 'التفضيلات';

  @override
  String get settingsPreferencesDescription =>
      'الإشعارات ولغة التطبيق والمظهر.';

  @override
  String get dashboardOverview => 'نظرة عامة على لوحة الطالب';

  @override
  String dashboardWelcome(Object name) {
    return 'مرحبًا بعودتك، $name';
  }

  @override
  String get browseCoursesSubtitle => 'واصل رحلتك التعليمية';

  @override
  String get browseCourseProgress => 'التقدم';

  @override
  String get browseViewCertificate => 'عرض الشهادة';

  @override
  String get browseBack => 'رجوع';

  @override
  String get settingsTitle => 'إعدادات الطالب';

  @override
  String get profileActive => 'نشط';

  @override
  String get homeCategoryCourses => 'دورات';

  @override
  String get certificatesStudentName => 'الطالب';
}
