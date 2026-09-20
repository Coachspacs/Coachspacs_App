import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The application title
  ///
  /// In ar, this message translates to:
  /// **'كوتش سبيس'**
  String get appTitle;

  /// Hint text in the search bar
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن دورات، مدربين...'**
  String get homeSearchHint;

  /// Label for the 'All' category chip
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get homeAll;

  /// Section header for featured courses
  ///
  /// In ar, this message translates to:
  /// **'دورات مميزة'**
  String get homeFeatured;

  /// Action link to view all items
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get homeViewAll;

  /// Section header for trending courses
  ///
  /// In ar, this message translates to:
  /// **'رائج الآن'**
  String get homeTrending;

  /// Bottom navigation label for Home
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// Bottom navigation label for Courses
  ///
  /// In ar, this message translates to:
  /// **'الدورات'**
  String get navCourses;

  /// Bottom navigation label for Search
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get navSearch;

  /// Bottom navigation label for Profile
  ///
  /// In ar, this message translates to:
  /// **'حسابي'**
  String get navProfile;

  /// Title shown when home data is empty
  ///
  /// In ar, this message translates to:
  /// **'لا توجد محتويات'**
  String get homeEmptyTitle;

  /// Subtitle shown when home data is empty
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على أي دورات حالياً'**
  String get homeEmptySubtitle;

  /// Title shown when an error occurs
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ'**
  String get homeErrorTitle;

  /// Subtitle shown when an error occurs
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء تحميل البيانات. يرجى المحاولة مرة أخرى.'**
  String get homeErrorSubtitle;

  /// Title shown when offline
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال'**
  String get homeOfflineTitle;

  /// Subtitle shown when offline
  ///
  /// In ar, this message translates to:
  /// **'يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى'**
  String get homeOfflineSubtitle;

  /// Retry button text
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get homeRetry;

  /// Login screen welcome title
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بعودتك'**
  String get loginWelcome;

  /// Label for email input field
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get loginEmailLabel;

  /// Label for password input field
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get loginPasswordLabel;

  /// Login button text
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginButton;

  /// Login button loading text
  ///
  /// In ar, this message translates to:
  /// **'جاري الدخول...'**
  String get loginButtonLoading;

  /// Forgot password link
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get loginForgotPassword;

  /// Text before register link on login
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟ '**
  String get loginNoAccount;

  /// Register link text on login
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get loginRegister;

  /// Signup screen title
  ///
  /// In ar, this message translates to:
  /// **'انضم إلى مستقبل\nالتعلم'**
  String get signupTitle;

  /// Label for full name input
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get signupNameLabel;

  /// Hint for name field
  ///
  /// In ar, this message translates to:
  /// **'مثال: أحمد محمد'**
  String get signupNameHint;

  /// Label for email input
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get signupEmailLabel;

  /// Label for password input
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get signupPasswordLabel;

  /// Terms agreement checkbox label
  ///
  /// In ar, this message translates to:
  /// **'أوافق على شروط الخدمة وسياسة الخصوصية'**
  String get signupTermsAgree;

  /// Create account button text
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get signupCreateAccount;

  /// Text before login link on signup
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟ '**
  String get signupHasAccount;

  /// Login link text on signup
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signupLogin;

  /// Validation error when fields are empty
  ///
  /// In ar, this message translates to:
  /// **'يرجى ملء جميع الحقول'**
  String get signupValidationError;

  /// Error when terms not agreed
  ///
  /// In ar, this message translates to:
  /// **'يجب الموافقة على شروط الخدمة'**
  String get signupTermsError;

  /// Message when signup is pending approval
  ///
  /// In ar, this message translates to:
  /// **'حسابك بانتظار الموافقة من الإدارة'**
  String get signupPendingApproval;

  /// Signup error message
  ///
  /// In ar, this message translates to:
  /// **'تعذر إنشاء الحساب'**
  String get signupError;

  /// Loading text on signup button
  ///
  /// In ar, this message translates to:
  /// **'جاري إنشاء الحساب...'**
  String get signupCreatingAccount;

  /// Label for the account-type selector
  ///
  /// In ar, this message translates to:
  /// **'أنا أنضم كـ'**
  String get signupRoleLabel;

  /// Student option in the account-type selector
  ///
  /// In ar, this message translates to:
  /// **'طالب'**
  String get signupRoleStudent;

  /// Instructor option in the account-type selector
  ///
  /// In ar, this message translates to:
  /// **'مدرب'**
  String get signupRoleInstructor;

  /// Error when email or password fields are empty
  ///
  /// In ar, this message translates to:
  /// **'أدخل البريد الإلكتروني وكلمة المرور'**
  String get loginValidationError;

  /// Forgot password screen title
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPasswordTitle;

  /// Forgot password screen subtitle
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني المرتبط بحسابك وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.'**
  String get forgotPasswordSubtitle;

  /// Label for the email input
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get forgotPasswordEmailLabel;

  /// Send reset link button
  ///
  /// In ar, this message translates to:
  /// **'إرسال رابط التحقق'**
  String get forgotPasswordButton;

  /// Loading text on the send button
  ///
  /// In ar, this message translates to:
  /// **'جاري الإرسال...'**
  String get forgotPasswordSending;

  /// Success message after sending the reset link
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني'**
  String get forgotPasswordSuccess;

  /// Error when the email field is empty
  ///
  /// In ar, this message translates to:
  /// **'أدخل البريد الإلكتروني'**
  String get forgotPasswordEmailEmpty;

  /// Link back to the login screen
  ///
  /// In ar, this message translates to:
  /// **'العودة لتسجيل الدخول'**
  String get forgotPasswordBackToLogin;

  /// Email verification screen title
  ///
  /// In ar, this message translates to:
  /// **'تمت إعادة إرسال البريد'**
  String get emailVerificationTitle;

  /// First part of the verification body text
  ///
  /// In ar, this message translates to:
  /// **'لقد أرسلنا رابط تحقق جديداً إلى بريدك الإلكتروني. يرجى تفقد صندوق الوارد ومجلد الرسائل غير المرغوب فيها للمتابعة.'**
  String get emailVerificationBodyPrefix;

  /// Second part of the verification body text
  ///
  /// In ar, this message translates to:
  /// **''**
  String get emailVerificationBodySuffix;

  /// Open email button
  ///
  /// In ar, this message translates to:
  /// **'اذهب إلى البريد الوارد'**
  String get emailVerificationOpenEmail;

  /// Hint after tapping the open-email button
  ///
  /// In ar, this message translates to:
  /// **'بعد الضغط على رابط التحقق، يمكنك تسجيل الدخول'**
  String get emailVerificationOpenEmailHint;

  /// Prompt before the resend link
  ///
  /// In ar, this message translates to:
  /// **'لم يصلك الرابط؟'**
  String get emailVerificationNotReceived;

  /// Loading text on the resend button
  ///
  /// In ar, this message translates to:
  /// **'جاري الإرسال...'**
  String get emailVerificationSending;

  /// Resend button with countdown. {time} is a mm:ss value.
  ///
  /// In ar, this message translates to:
  /// **'انتظر {time} ثانية لإعادة الإرسال.'**
  String emailVerificationResendCountdown(String time);

  /// Success message after resending the link
  ///
  /// In ar, this message translates to:
  /// **'تم إعادة إرسال رابط التحقق'**
  String get emailVerificationResent;

  /// Title on the successful email verification screen
  ///
  /// In ar, this message translates to:
  /// **'تم التحقق من البريد الإلكتروني بنجاح!'**
  String get emailVerifiedSuccessTitle;

  /// Body on the successful email verification screen
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد بريدك الإلكتروني. يمكنك الآن إكمال ملفك الشخصي وبدء رحلتك التدريبية.'**
  String get emailVerifiedSuccessBody;

  /// Continue action after email verification
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get emailVerifiedContinue;

  /// Title when an email link was already used
  ///
  /// In ar, this message translates to:
  /// **'تم التحقق مسبقاً'**
  String get emailAlreadyVerifiedTitle;

  /// Body when an email link was already used
  ///
  /// In ar, this message translates to:
  /// **'تم التحقق من عنوان بريدك الإلكتروني مسبقاً. يمكنك تسجيل الدخول إلى حسابك مباشرةً.'**
  String get emailAlreadyVerifiedBody;

  /// Sign in action when email is already verified
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول الآن'**
  String get emailAlreadyVerifiedSignIn;

  /// Pending approval screen title
  ///
  /// In ar, this message translates to:
  /// **'بانتظار موافقة الإدارة'**
  String get pendingApprovalTitle;

  /// Pending approval screen subtitle
  ///
  /// In ar, this message translates to:
  /// **'تم استلام طلبك بنجاح. سيتم تفعيل حسابك المدربي بعد موافقة الإدارة. سنعلمك فور اكتمال المراجعة.'**
  String get pendingApprovalSubtitle;

  /// Log out button on the pending approval screen
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get pendingApprovalLogout;

  /// Heading for the under-review variant
  ///
  /// In ar, this message translates to:
  /// **'حسابك قيد المراجعة'**
  String get accountUnderReviewTitle;

  /// Body for the under-review screen
  ///
  /// In ar, this message translates to:
  /// **'شكراً لانضمامك إلى كوتش سبيس. فريقنا يراجع معلوماتك حالياً لضمان أعلى جودة لطلابنا. سنعلمك فور تفعيل حسابك.'**
  String get accountUnderReviewSubtitle;

  /// CTA on the under-review screen
  ///
  /// In ar, this message translates to:
  /// **'التواصل مع الدعم'**
  String get accountUnderReviewContactSupport;

  /// Title for the rejected instructor screen
  ///
  /// In ar, this message translates to:
  /// **'لم تتم الموافقة على الحساب'**
  String get accountNotApprovedTitle;

  /// Subtitle for the rejected screen
  ///
  /// In ar, this message translates to:
  /// **'نأسف، لم تتم الموافقة على طلب انضمامك كمدرب من قبل الإدارة في الوقت الحالي.'**
  String get accountNotApprovedSubtitle;

  /// Label above the rejection reason text
  ///
  /// In ar, this message translates to:
  /// **'سبب الرفض:'**
  String get accountNotApprovedReasonLabel;

  /// Fallback rejection reason
  ///
  /// In ar, this message translates to:
  /// **'تعذر التحقق من الشهادات المهنية المرفقة. يرجى التأكد من وضوح المستندات وصلاحيتها.'**
  String get accountNotApprovedDefaultReason;

  /// Heading of the help card on the rejected screen
  ///
  /// In ar, this message translates to:
  /// **'تحتاج مساعدة؟'**
  String get accountNotApprovedNeedHelp;

  /// Body of the help card on the rejected screen
  ///
  /// In ar, this message translates to:
  /// **'إذا كنت تعتقد أن هذا خطأ أو ترغب في تقديم مستندات إضافية، يرجى التواصل مع فريق الدعم:'**
  String get accountNotApprovedHelpBody;

  /// Support mailbox shown as a mailto link
  ///
  /// In ar, this message translates to:
  /// **'support@coachspace.com'**
  String get supportEmail;

  /// Sign-out link on the rejected screen
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get accountNotApprovedSignOut;

  /// Intro paragraph on the support form screen
  ///
  /// In ar, this message translates to:
  /// **'هل لديك سؤال أو تحتاج مساعدة؟ فريقنا هنا لمساعدتك على الاستفادة القصوى من رحلتك التدريبية.'**
  String get supportIntro;

  /// Title inside the support card
  ///
  /// In ar, this message translates to:
  /// **'إرسال رسالة'**
  String get supportSendMessageTitle;

  /// Label for the message textarea
  ///
  /// In ar, this message translates to:
  /// **'الرسالة'**
  String get supportMessageLabel;

  /// Placeholder for the message textarea
  ///
  /// In ar, this message translates to:
  /// **'صف مشكلتك بالتفصيل...'**
  String get supportMessageHint;

  /// Primary CTA on the support screen
  ///
  /// In ar, this message translates to:
  /// **'إرسال الرسالة'**
  String get supportSendButton;

  /// Loading state for the support send button
  ///
  /// In ar, this message translates to:
  /// **'جاري الإرسال...'**
  String get supportSending;

  /// Secondary cancel link on the support screen
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get supportCancel;

  /// Validation when the support message is empty
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال الرسالة'**
  String get supportMessageEmpty;

  /// Validation when the support message is too short
  ///
  /// In ar, this message translates to:
  /// **'الرسالة قصيرة جداً'**
  String get supportMessageTooShort;

  /// Confirmation after sending the support message
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الرسالة. سنعود إليك قريباً.'**
  String get supportMessageSent;

  /// Title for the expired-link screen
  ///
  /// In ar, this message translates to:
  /// **'انتهت صلاحية الرابط'**
  String get linkExpiredTitle;

  /// Subtitle for the expired-link screen
  ///
  /// In ar, this message translates to:
  /// **'رابط التحقق الذي ضغطت عليه لم يعد صالحاً أو تم استخدامه مسبقاً. يرجى طلب رابط جديد للتحقق من حسابك.'**
  String get linkExpiredSubtitle;

  /// CTA to resend the verification link on the expired screen
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال رابط التحقق'**
  String get linkExpiredResendButton;

  /// Secondary back action on the expired-link screen
  ///
  /// In ar, this message translates to:
  /// **'العودة لتسجيل الدخول'**
  String get linkExpiredBackToLogin;

  /// Error when resend is attempted without an email
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد بريد إلكتروني. يرجى تسجيل الدخول مرة أخرى.'**
  String get linkExpiredNoEmail;

  /// Profile updated success message
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الملف الشخصي بنجاح.'**
  String get settingsSaveSuccess;

  /// Avatar updated success message
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الصورة الرمزية.'**
  String get settingsAvatarUpdated;

  /// Email change verification sent
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رسالة تأكيد إلى بريدك الجديد. يرجى التأكيد من صندوق الوارد.'**
  String get settingsEmailChangeSent;

  /// Change email dialog title
  ///
  /// In ar, this message translates to:
  /// **'تغيير البريد الإلكتروني'**
  String get settingsChangeEmailTitle;

  /// New email label
  ///
  /// In ar, this message translates to:
  /// **'البريد الجديد'**
  String get settingsNewEmailLabel;

  /// Cancel button
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get settingsCancel;

  /// Send button
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get settingsSend;

  /// Change link
  ///
  /// In ar, this message translates to:
  /// **'تغيير'**
  String get settingsChange;

  /// No description provided for @courseDetailsLoading.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل تفاصيل الدورة...'**
  String get courseDetailsLoading;

  /// No description provided for @courseDetailsError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل تفاصيل الدورة.'**
  String get courseDetailsError;

  /// No description provided for @courseDetailsRetry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get courseDetailsRetry;

  /// No description provided for @courseDetailsCurriculumEmpty.
  ///
  /// In ar, this message translates to:
  /// **'المنهج غير متاح حالياً.'**
  String get courseDetailsCurriculumEmpty;

  /// No description provided for @courseDetailsAlreadyEnrolled.
  ///
  /// In ar, this message translates to:
  /// **'مسجل بالفعل'**
  String get courseDetailsAlreadyEnrolled;

  /// No description provided for @courseDetailsContinueLearning.
  ///
  /// In ar, this message translates to:
  /// **'تابع التعلم من حيث توقفت.'**
  String get courseDetailsContinueLearning;

  /// No description provided for @courseDetailsContinue.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get courseDetailsContinue;

  /// No description provided for @courseDetailsEnrollFree.
  ///
  /// In ar, this message translates to:
  /// **'سجّل مجاناً'**
  String get courseDetailsEnrollFree;

  /// No description provided for @courseDetailsAddToCart.
  ///
  /// In ar, this message translates to:
  /// **'أضف إلى السلة'**
  String get courseDetailsAddToCart;

  /// No description provided for @courseDetailsBuyNow.
  ///
  /// In ar, this message translates to:
  /// **'اشترِ الآن'**
  String get courseDetailsBuyNow;

  /// No description provided for @courseDetailsAddedToCart.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإضافة إلى السلة.'**
  String get courseDetailsAddedToCart;

  /// No description provided for @courseDetailsAddToCartConfirm.
  ///
  /// In ar, this message translates to:
  /// **'أضف إلى السلة؟'**
  String get courseDetailsAddToCartConfirm;

  /// No description provided for @courseDetailsAddToCartMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد إضافة هذه الدورة إلى سلتك؟'**
  String get courseDetailsAddToCartMessage;

  /// No description provided for @courseDetailsCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get courseDetailsCancel;

  /// No description provided for @courseDetailsYesAdd.
  ///
  /// In ar, this message translates to:
  /// **'نعم، أضفها'**
  String get courseDetailsYesAdd;

  /// No description provided for @courseDetailsMoneyBack.
  ///
  /// In ar, this message translates to:
  /// **'ضمان استرداد الأموال لمدة 30 يوماً'**
  String get courseDetailsMoneyBack;

  /// No description provided for @courseDetailsIncludes.
  ///
  /// In ar, this message translates to:
  /// **'هذه الدورة تشمل'**
  String get courseDetailsIncludes;

  /// No description provided for @courseDetailsCurriculum.
  ///
  /// In ar, this message translates to:
  /// **'منهج الدورة'**
  String get courseDetailsCurriculum;

  /// No description provided for @courseDetailsAboutInstructor.
  ///
  /// In ar, this message translates to:
  /// **'عن المدرب'**
  String get courseDetailsAboutInstructor;

  /// No description provided for @catalogExplore.
  ///
  /// In ar, this message translates to:
  /// **'استكشف الدورات'**
  String get catalogExplore;

  /// No description provided for @catalogSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن الدورة المناسبة لتطوير مهاراتك.'**
  String get catalogSubtitle;

  /// No description provided for @catalogAllCourses.
  ///
  /// In ar, this message translates to:
  /// **'جميع الدورات'**
  String get catalogAllCourses;

  /// No description provided for @catalogCoursesCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} دورة'**
  String catalogCoursesCount(Object count);

  /// No description provided for @catalogNoCourses.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على دورات'**
  String get catalogNoCourses;

  /// No description provided for @catalogTryAdjusting.
  ///
  /// In ar, this message translates to:
  /// **'حاول تعديل الفلاتر أو البحث.'**
  String get catalogTryAdjusting;

  /// No description provided for @catalogSort.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب'**
  String get catalogSort;

  /// No description provided for @catalogSortCourses.
  ///
  /// In ar, this message translates to:
  /// **'ترتيب الدورات'**
  String get catalogSortCourses;

  /// No description provided for @catalogNewest.
  ///
  /// In ar, this message translates to:
  /// **'الأحدث'**
  String get catalogNewest;

  /// No description provided for @catalogPriceLowHigh.
  ///
  /// In ar, this message translates to:
  /// **'السعر: من الأقل إلى الأعلى'**
  String get catalogPriceLowHigh;

  /// No description provided for @catalogPriceHighLow.
  ///
  /// In ar, this message translates to:
  /// **'السعر: من الأعلى إلى الأقل'**
  String get catalogPriceHighLow;

  /// No description provided for @myLearningTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعلمي'**
  String get myLearningTitle;

  /// No description provided for @myLearningNoCourses.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد دورات بعد'**
  String get myLearningNoCourses;

  /// No description provided for @myLearningBrowseHint.
  ///
  /// In ar, this message translates to:
  /// **'تصفّح الكتالوج وسجّل في أول دورة لك.'**
  String get myLearningBrowseHint;

  /// No description provided for @myLearningBrowseCourses.
  ///
  /// In ar, this message translates to:
  /// **'تصفح الدورات'**
  String get myLearningBrowseCourses;

  /// No description provided for @myLearningEnrolled.
  ///
  /// In ar, this message translates to:
  /// **'مسجل'**
  String get myLearningEnrolled;

  /// No description provided for @myLearningInProgress.
  ///
  /// In ar, this message translates to:
  /// **'قيد التقدم'**
  String get myLearningInProgress;

  /// No description provided for @myLearningCompleted.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get myLearningCompleted;

  /// No description provided for @myLearningContinueSection.
  ///
  /// In ar, this message translates to:
  /// **'تابع التعلم'**
  String get myLearningContinueSection;

  /// No description provided for @myLearningCompletedSection.
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get myLearningCompletedSection;

  /// No description provided for @securityTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأمان'**
  String get securityTitle;

  /// No description provided for @securityCurrentPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية'**
  String get securityCurrentPassword;

  /// No description provided for @securityNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get securityNewPassword;

  /// No description provided for @securityConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور الجديدة'**
  String get securityConfirmPassword;

  /// No description provided for @securitySaveChanges.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التغييرات'**
  String get securitySaveChanges;

  /// No description provided for @securityPasswordChanged.
  ///
  /// In ar, this message translates to:
  /// **'تم تغيير كلمة المرور بنجاح.'**
  String get securityPasswordChanged;

  /// No description provided for @securityFillAllFields.
  ///
  /// In ar, this message translates to:
  /// **'يرجى ملء جميع الحقول.'**
  String get securityFillAllFields;

  /// No description provided for @securityPasswordsNoMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين.'**
  String get securityPasswordsNoMatch;

  /// No description provided for @profileInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الملف الشخصي'**
  String get profileInfoTitle;

  /// No description provided for @profileInfoAvatar.
  ///
  /// In ar, this message translates to:
  /// **'الصورة الرمزية'**
  String get profileInfoAvatar;

  /// No description provided for @profileInfoAvatarHint.
  ///
  /// In ar, this message translates to:
  /// **'ارفع صورة واضحة ليساعد الطلاب على التعرف عليك.'**
  String get profileInfoAvatarHint;

  /// No description provided for @profileInfoAvatarFormat.
  ///
  /// In ar, this message translates to:
  /// **'JPG, PNG, WEBP حتى 5 ميغابايت.'**
  String get profileInfoAvatarFormat;

  /// No description provided for @profileInfoFullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get profileInfoFullName;

  /// No description provided for @profileInfoEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get profileInfoEmail;

  /// No description provided for @profileInfoSaveChanges.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التغييرات'**
  String get profileInfoSaveChanges;

  /// No description provided for @profileInfoSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الملف الشخصي بنجاح.'**
  String get profileInfoSaved;

  /// No description provided for @profileInfoAvatarUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الصورة الرمزية.'**
  String get profileInfoAvatarUpdated;

  /// No description provided for @cartTitle.
  ///
  /// In ar, this message translates to:
  /// **'سلتي'**
  String get cartTitle;

  /// No description provided for @cartEmpty.
  ///
  /// In ar, this message translates to:
  /// **'سلتك فارغة'**
  String get cartEmpty;

  /// No description provided for @cartEmptyHint.
  ///
  /// In ar, this message translates to:
  /// **'تصفّح الدورات وأضفها إلى سلتك.'**
  String get cartEmptyHint;

  /// No description provided for @checkoutTitle.
  ///
  /// In ar, this message translates to:
  /// **'إتمام الشراء'**
  String get checkoutTitle;

  /// No description provided for @checkoutNoItems.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناصر للشراء'**
  String get checkoutNoItems;

  /// No description provided for @checkoutNoItemsHint.
  ///
  /// In ar, this message translates to:
  /// **'أضف دورات إلى سلتك أولاً.'**
  String get checkoutNoItemsHint;

  /// No description provided for @checkoutGoBack.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get checkoutGoBack;

  /// No description provided for @orderHistoryTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجل الطلبات'**
  String get orderHistoryTitle;

  /// No description provided for @orderHistoryEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد طلبات بعد'**
  String get orderHistoryEmpty;

  /// No description provided for @orderHistoryEmptyHint.
  ///
  /// In ar, this message translates to:
  /// **'سيظهر سجل مشترياتك هنا.'**
  String get orderHistoryEmptyHint;

  /// No description provided for @certificatesTitle.
  ///
  /// In ar, this message translates to:
  /// **'الشهادات'**
  String get certificatesTitle;

  /// No description provided for @certificatesEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد شهادات بعد'**
  String get certificatesEmpty;

  /// No description provided for @certificatesEmptyHint.
  ///
  /// In ar, this message translates to:
  /// **'أكمل الدورات للحصول على شهادات.'**
  String get certificatesEmptyHint;

  /// No description provided for @contactUsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get contactUsTitle;

  /// No description provided for @contactUsIntro.
  ///
  /// In ar, this message translates to:
  /// **'هل لديك سؤال أو تحتاج مساعدة؟ فريقنا هنا لمساعدتك.'**
  String get contactUsIntro;

  /// No description provided for @contactUsSendMessage.
  ///
  /// In ar, this message translates to:
  /// **'إرسال رسالة'**
  String get contactUsSendMessage;

  /// No description provided for @contactUsMessageLabel.
  ///
  /// In ar, this message translates to:
  /// **'الرسالة'**
  String get contactUsMessageLabel;

  /// No description provided for @contactUsMessageHint.
  ///
  /// In ar, this message translates to:
  /// **'صف مشكلتك بالتفصيل...'**
  String get contactUsMessageHint;

  /// No description provided for @contactUsSendButton.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الرسالة'**
  String get contactUsSendButton;

  /// No description provided for @contactUsSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال الرسالة. سنعود إليك قريباً.'**
  String get contactUsSent;

  /// No description provided for @contactUsEmpty.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال الرسالة.'**
  String get contactUsEmpty;

  /// No description provided for @contactUsTooShort.
  ///
  /// In ar, this message translates to:
  /// **'الرسالة قصيرة جداً.'**
  String get contactUsTooShort;

  /// No description provided for @learningSettingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات التعلم'**
  String get learningSettingsTitle;

  /// No description provided for @learningSettingsGoal.
  ///
  /// In ar, this message translates to:
  /// **'هدف التعلم'**
  String get learningSettingsGoal;

  /// No description provided for @learningSettingsGoalHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: بناء مهارات عملية'**
  String get learningSettingsGoalHint;

  /// No description provided for @learningSettingsField.
  ///
  /// In ar, this message translates to:
  /// **'مجال الاهتمام'**
  String get learningSettingsField;

  /// No description provided for @learningSettingsFieldHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: علم البيانات والذكاء الاصطناعي'**
  String get learningSettingsFieldHint;

  /// No description provided for @learningSettingsCertName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الشهادة'**
  String get learningSettingsCertName;

  /// No description provided for @learningSettingsCertHint.
  ///
  /// In ar, this message translates to:
  /// **'الاسم المطبوع على الشهادات'**
  String get learningSettingsCertHint;

  /// No description provided for @learningSettingsPlaybackSpeed.
  ///
  /// In ar, this message translates to:
  /// **'سرعة التشغيل'**
  String get learningSettingsPlaybackSpeed;

  /// No description provided for @learningSettingsPublicProfile.
  ///
  /// In ar, this message translates to:
  /// **'الملف العام'**
  String get learningSettingsPublicProfile;

  /// No description provided for @learningSettingsPublicHint.
  ///
  /// In ar, this message translates to:
  /// **'السماح للآخرين برؤية دوراتك المسجلة.'**
  String get learningSettingsPublicHint;

  /// No description provided for @learningSettingsSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ إعدادات التعلم.'**
  String get learningSettingsSaved;

  /// No description provided for @preferencesTitle.
  ///
  /// In ar, this message translates to:
  /// **'التفضيلات'**
  String get preferencesTitle;

  /// No description provided for @preferencesEmailNotif.
  ///
  /// In ar, this message translates to:
  /// **'إشعارات البريد الإلكتروني'**
  String get preferencesEmailNotif;

  /// No description provided for @preferencesEmailNotifHint.
  ///
  /// In ar, this message translates to:
  /// **'استلام تحديثات الدورات عبر البريد.'**
  String get preferencesEmailNotifHint;

  /// No description provided for @preferencesPushNotif.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات الفورية'**
  String get preferencesPushNotif;

  /// No description provided for @preferencesPushNotifHint.
  ///
  /// In ar, this message translates to:
  /// **'تنبيهات حول دورات جديدة وإنجازات.'**
  String get preferencesPushNotifHint;

  /// No description provided for @preferencesLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get preferencesLanguage;

  /// No description provided for @preferencesTheme.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get preferencesTheme;

  /// No description provided for @preferencesSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم حفظ التفضيلات.'**
  String get preferencesSaved;

  /// No description provided for @commonRetry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get commonCancel;

  /// No description provided for @commonDone.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get commonDone;

  /// No description provided for @commonSave.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get commonSave;

  /// No description provided for @commonError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ. حاول مرة أخرى.'**
  String get commonError;

  /// No description provided for @errorOffline.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت. تحقق من شبكتك وحاول مرة أخرى.'**
  String get errorOffline;

  /// No description provided for @errorNotFound.
  ///
  /// In ar, this message translates to:
  /// **'العنصر المطلوب غير موجود.'**
  String get errorNotFound;

  /// No description provided for @errorServer.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الخادم. حاول مرة أخرى لاحقًا.'**
  String get errorServer;

  /// No description provided for @errorForbidden.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح لك بتنفيذ هذا الإجراء.'**
  String get errorForbidden;

  /// No description provided for @errorConflict.
  ///
  /// In ar, this message translates to:
  /// **'هذا الإجراء يتعارض مع الحالة الحالية.'**
  String get errorConflict;

  /// No description provided for @errorRateLimited.
  ///
  /// In ar, this message translates to:
  /// **'محاولات كثيرة. انتظر لحظة من فضلك.'**
  String get errorRateLimited;

  /// No description provided for @errorSessionExpired.
  ///
  /// In ar, this message translates to:
  /// **'انتهت جلستك. يرجى تسجيل الدخول مرة أخرى.'**
  String get errorSessionExpired;

  /// No description provided for @errorUnknown.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ. حاول مرة أخرى.'**
  String get errorUnknown;

  /// No description provided for @catalogSearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن دورات...'**
  String get catalogSearchHint;

  /// No description provided for @catalogViewCourse.
  ///
  /// In ar, this message translates to:
  /// **'عرض الدورة'**
  String get catalogViewCourse;

  /// No description provided for @catalogFilters.
  ///
  /// In ar, this message translates to:
  /// **'التصفية'**
  String get catalogFilters;

  /// No description provided for @catalogFilterLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get catalogFilterLanguage;

  /// No description provided for @catalogFilterLevel.
  ///
  /// In ar, this message translates to:
  /// **'المستوى'**
  String get catalogFilterLevel;

  /// No description provided for @catalogFilterPrice.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get catalogFilterPrice;

  /// No description provided for @catalogAllLevels.
  ///
  /// In ar, this message translates to:
  /// **'كل المستويات'**
  String get catalogAllLevels;

  /// No description provided for @catalogAllPrices.
  ///
  /// In ar, this message translates to:
  /// **'كل الأسعار'**
  String get catalogAllPrices;

  /// No description provided for @catalogFilterFree.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get catalogFilterFree;

  /// No description provided for @catalogUnder50.
  ///
  /// In ar, this message translates to:
  /// **'أقل من 50\$'**
  String get catalogUnder50;

  /// No description provided for @catalog50to100.
  ///
  /// In ar, this message translates to:
  /// **'50\$ - 100\$'**
  String get catalog50to100;

  /// No description provided for @catalog100plus.
  ///
  /// In ar, this message translates to:
  /// **'أكثر من 100\$'**
  String get catalog100plus;

  /// No description provided for @catalogApplyFilters.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق التصفية'**
  String get catalogApplyFilters;

  /// No description provided for @catalogResetFilters.
  ///
  /// In ar, this message translates to:
  /// **'مسح الكل'**
  String get catalogResetFilters;

  /// No description provided for @catalogResetAll.
  ///
  /// In ar, this message translates to:
  /// **'مسح الكل'**
  String get catalogResetAll;

  /// No description provided for @catalogFilterEnglish.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get catalogFilterEnglish;

  /// No description provided for @catalogFilterArabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get catalogFilterArabic;

  /// No description provided for @catalogLevelBeginner.
  ///
  /// In ar, this message translates to:
  /// **'مبتدئ'**
  String get catalogLevelBeginner;

  /// No description provided for @catalogLevelIntermediate.
  ///
  /// In ar, this message translates to:
  /// **'متوسط'**
  String get catalogLevelIntermediate;

  /// No description provided for @catalogLevelAdvanced.
  ///
  /// In ar, this message translates to:
  /// **'متقدم'**
  String get catalogLevelAdvanced;

  /// No description provided for @catalogLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الدورات.'**
  String get catalogLoadFailed;

  /// No description provided for @catalogFree.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get catalogFree;

  /// No description provided for @courseDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الدورة'**
  String get courseDetailsTitle;

  /// No description provided for @courseDetailsWatchPreview.
  ///
  /// In ar, this message translates to:
  /// **'مشاهدة المعاينة'**
  String get courseDetailsWatchPreview;

  /// No description provided for @courseDetailsPreviewTitle.
  ///
  /// In ar, this message translates to:
  /// **'معاينة الدورة'**
  String get courseDetailsPreviewTitle;

  /// No description provided for @courseDetailsPreviewBody.
  ///
  /// In ar, this message translates to:
  /// **'هذه معاينة تعريفية للدورة. يمكنك مشاهدتها دون تسجيل الدخول.'**
  String get courseDetailsPreviewBody;

  /// No description provided for @courseDetailsClosePreview.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق المعاينة'**
  String get courseDetailsClosePreview;

  /// No description provided for @courseDetailsInstructorBio.
  ///
  /// In ar, this message translates to:
  /// **'مدرب متمرس ومربٍّ محترف.'**
  String get courseDetailsInstructorBio;

  /// No description provided for @courseDetailsLessonsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} درس'**
  String courseDetailsLessonsCount(Object count);

  /// No description provided for @courseDetailsTotalDuration.
  ///
  /// In ar, this message translates to:
  /// **'{hours} ساعات من دروس الفيديو'**
  String courseDetailsTotalDuration(Object hours);

  /// No description provided for @courseDetailsDownloadableResources.
  ///
  /// In ar, this message translates to:
  /// **'مصادر قابلة للتنزيل'**
  String get courseDetailsDownloadableResources;

  /// No description provided for @courseDetailsProjects.
  ///
  /// In ar, this message translates to:
  /// **'مشاريع وتمارين عملية'**
  String get courseDetailsProjects;

  /// No description provided for @courseDetailsLifetimeAccess.
  ///
  /// In ar, this message translates to:
  /// **'وصول مدى الحياة'**
  String get courseDetailsLifetimeAccess;

  /// No description provided for @courseDetailsCertificate.
  ///
  /// In ar, this message translates to:
  /// **'شهادة إتمام'**
  String get courseDetailsCertificate;

  /// No description provided for @courseDetailsAddToCartFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذرت إضافة الدورة إلى السلة.'**
  String get courseDetailsAddToCartFailed;

  /// No description provided for @courseDetailsLevel.
  ///
  /// In ar, this message translates to:
  /// **'المستوى'**
  String get courseDetailsLevel;

  /// No description provided for @courseDetailsLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get courseDetailsLanguage;

  /// No description provided for @courseDetailsEnrollSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم التسجيل بنجاح.'**
  String get courseDetailsEnrollSuccess;

  /// No description provided for @courseDetailsEnrollFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر التسجيل في هذه الدورة.'**
  String get courseDetailsEnrollFailed;

  /// No description provided for @myLearningNoProgress.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد دورات قيد التقدم بعد.'**
  String get myLearningNoProgress;

  /// No description provided for @myLearningCourseCompleted.
  ///
  /// In ar, this message translates to:
  /// **'اكتملت الدورة'**
  String get myLearningCourseCompleted;

  /// No description provided for @myLearningContinueWhereLeft.
  ///
  /// In ar, this message translates to:
  /// **'أكمل من حيث توقفت'**
  String get myLearningContinueWhereLeft;

  /// No description provided for @myLearningMyCourses.
  ///
  /// In ar, this message translates to:
  /// **'دوراتي'**
  String get myLearningMyCourses;

  /// No description provided for @myLearningViewAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get myLearningViewAll;

  /// No description provided for @myLearningCertificates.
  ///
  /// In ar, this message translates to:
  /// **'شهاداتي'**
  String get myLearningCertificates;

  /// No description provided for @myLearningCertificateEarned.
  ///
  /// In ar, this message translates to:
  /// **'شهادة مكتسبة'**
  String get myLearningCertificateEarned;

  /// No description provided for @myLearningRecentActivity.
  ///
  /// In ar, this message translates to:
  /// **'النشاط الأخير'**
  String get myLearningRecentActivity;

  /// No description provided for @myLearningEnrolledLabel.
  ///
  /// In ar, this message translates to:
  /// **'مسجّل'**
  String get myLearningEnrolledLabel;

  /// No description provided for @myLearningCertificatesLabel.
  ///
  /// In ar, this message translates to:
  /// **'الشهادات'**
  String get myLearningCertificatesLabel;

  /// No description provided for @myLearningCourseSuffix.
  ///
  /// In ar, this message translates to:
  /// **'دورة'**
  String get myLearningCourseSuffix;

  /// No description provided for @myLearningCoursesSuffix.
  ///
  /// In ar, this message translates to:
  /// **'دورات'**
  String get myLearningCoursesSuffix;

  /// No description provided for @myLearningEarned.
  ///
  /// In ar, this message translates to:
  /// **'مكتسبة'**
  String get myLearningEarned;

  /// No description provided for @myLearningInProgressFooter.
  ///
  /// In ar, this message translates to:
  /// **'قيد التقدم'**
  String get myLearningInProgressFooter;

  /// No description provided for @myLearningActiveCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} نشطة'**
  String myLearningActiveCount(Object count);

  /// No description provided for @myLearningVerifiedCredential.
  ///
  /// In ar, this message translates to:
  /// **'• اعتماد موثّق'**
  String get myLearningVerifiedCredential;

  /// No description provided for @myLearningAverageProgress.
  ///
  /// In ar, this message translates to:
  /// **'متوسط التقدم'**
  String get myLearningAverageProgress;

  /// No description provided for @myLearningLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل دوراتك.'**
  String get myLearningLoadFailed;

  /// No description provided for @myLearningNoCertificates.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد شهادات بعد.'**
  String get myLearningNoCertificates;

  /// No description provided for @myLearningContinue.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get myLearningContinue;

  /// No description provided for @lessonPlayerTitle.
  ///
  /// In ar, this message translates to:
  /// **'الدرس'**
  String get lessonPlayerTitle;

  /// No description provided for @lessonPlayerOpenVideo.
  ///
  /// In ar, this message translates to:
  /// **'فتح الفيديو'**
  String get lessonPlayerOpenVideo;

  /// No description provided for @lessonPlayerMarkComplete.
  ///
  /// In ar, this message translates to:
  /// **'إكمال الدرس'**
  String get lessonPlayerMarkComplete;

  /// No description provided for @lessonPlayerPrevious.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get lessonPlayerPrevious;

  /// No description provided for @lessonPlayerNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get lessonPlayerNext;

  /// No description provided for @dashboardEnrolledLabel.
  ///
  /// In ar, this message translates to:
  /// **'مسجّل'**
  String get dashboardEnrolledLabel;

  /// No description provided for @dashboardCertificatesLabel.
  ///
  /// In ar, this message translates to:
  /// **'الشهادات'**
  String get dashboardCertificatesLabel;

  /// No description provided for @dashboardAverageProgressLabel.
  ///
  /// In ar, this message translates to:
  /// **'متوسط التقدم'**
  String get dashboardAverageProgressLabel;

  /// No description provided for @dashboardContinueLearning.
  ///
  /// In ar, this message translates to:
  /// **'متابعة التعلم'**
  String get dashboardContinueLearning;

  /// No description provided for @dashboardNoEnrollments.
  ///
  /// In ar, this message translates to:
  /// **'لم تسجّل في أي دورة بعد.'**
  String get dashboardNoEnrollments;

  /// No description provided for @dashboardLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل لوحة التحكم.'**
  String get dashboardLoadFailed;

  /// No description provided for @dashboardCoursesCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} دورات'**
  String dashboardCoursesCount(Object count);

  /// No description provided for @dashboardEarnedCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} مكتسبة'**
  String dashboardEarnedCount(Object count);

  /// No description provided for @securityCurrentRequired.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور الحالية.'**
  String get securityCurrentRequired;

  /// No description provided for @securityNewRequired.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور الجديدة.'**
  String get securityNewRequired;

  /// No description provided for @securityConfirmRequired.
  ///
  /// In ar, this message translates to:
  /// **'أكد كلمة المرور الجديدة.'**
  String get securityConfirmRequired;

  /// No description provided for @securityTooShort.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تكون كلمة المرور 8 أحرف على الأقل.'**
  String get securityTooShort;

  /// No description provided for @securitySaveFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تغيير كلمة المرور.'**
  String get securitySaveFailed;

  /// No description provided for @profileStudent.
  ///
  /// In ar, this message translates to:
  /// **'طالب'**
  String get profileStudent;

  /// No description provided for @profileInstructor.
  ///
  /// In ar, this message translates to:
  /// **'مدرب'**
  String get profileInstructor;

  /// No description provided for @profileSignOut.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get profileSignOut;

  /// No description provided for @profileSignOutConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تسجيل الخروج؟'**
  String get profileSignOutConfirm;

  /// No description provided for @profileAccountSettings.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الحساب'**
  String get profileAccountSettings;

  /// No description provided for @profileOrderHistory.
  ///
  /// In ar, this message translates to:
  /// **'سجل الطلبات'**
  String get profileOrderHistory;

  /// No description provided for @profileMyCart.
  ///
  /// In ar, this message translates to:
  /// **'سلتي'**
  String get profileMyCart;

  /// No description provided for @profileCertificates.
  ///
  /// In ar, this message translates to:
  /// **'الشهادات'**
  String get profileCertificates;

  /// No description provided for @profileContactUs.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا'**
  String get profileContactUs;

  /// No description provided for @profileLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل ملفك الشخصي.'**
  String get profileLoadFailed;

  /// No description provided for @profileInfoChange.
  ///
  /// In ar, this message translates to:
  /// **'تغيير'**
  String get profileInfoChange;

  /// No description provided for @profileInfoEmailNote.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إرسال رابط تأكيد إلى العنوان الجديد.'**
  String get profileInfoEmailNote;

  /// No description provided for @profileInfoChangeEmail.
  ///
  /// In ar, this message translates to:
  /// **'تغيير البريد الإلكتروني'**
  String get profileInfoChangeEmail;

  /// No description provided for @profileInfoNewEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني الجديد'**
  String get profileInfoNewEmail;

  /// No description provided for @profileInfoEmailChangeSent.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال رابط التأكيد إلى بريدك الجديد.'**
  String get profileInfoEmailChangeSent;

  /// No description provided for @profileInfoPhone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف'**
  String get profileInfoPhone;

  /// No description provided for @profileInfoHeadline.
  ///
  /// In ar, this message translates to:
  /// **'المسمى الوظيفي'**
  String get profileInfoHeadline;

  /// No description provided for @profileInfoNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال اسمك الكامل.'**
  String get profileInfoNameRequired;

  /// No description provided for @profileInfoLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل ملفك الشخصي.'**
  String get profileInfoLoadFailed;

  /// No description provided for @profileInfoSaveFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ ملفك الشخصي.'**
  String get profileInfoSaveFailed;

  /// No description provided for @profileInfoAvatarFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر رفع الصورة.'**
  String get profileInfoAvatarFailed;

  /// No description provided for @cartRemove.
  ///
  /// In ar, this message translates to:
  /// **'إزالة'**
  String get cartRemove;

  /// No description provided for @cartRemoveConfirm.
  ///
  /// In ar, this message translates to:
  /// **'إزالة من السلة؟'**
  String get cartRemoveConfirm;

  /// No description provided for @cartRemoveConfirmMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد إزالة هذه الدورة من سلتك؟'**
  String get cartRemoveConfirmMessage;

  /// No description provided for @cartRemoved.
  ///
  /// In ar, this message translates to:
  /// **'تمت إزالة العنصر من السلة.'**
  String get cartRemoved;

  /// No description provided for @cartItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عناصر'**
  String cartItemsCount(Object count);

  /// No description provided for @cartSubtotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع الفرعي'**
  String get cartSubtotal;

  /// No description provided for @cartDiscount.
  ///
  /// In ar, this message translates to:
  /// **'الخصم'**
  String get cartDiscount;

  /// No description provided for @cartTotal.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get cartTotal;

  /// No description provided for @cartCheckout.
  ///
  /// In ar, this message translates to:
  /// **'إتمام الشراء'**
  String get cartCheckout;

  /// No description provided for @cartBrowseCourses.
  ///
  /// In ar, this message translates to:
  /// **'تصفح الدورات'**
  String get cartBrowseCourses;

  /// No description provided for @cartLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل سلتك.'**
  String get cartLoadFailed;

  /// No description provided for @cartRemoveFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذرت إزالة العنصر.'**
  String get cartRemoveFailed;

  /// No description provided for @cartAddFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذرت إضافة الدورة إلى السلة.'**
  String get cartAddFailed;

  /// No description provided for @checkoutOrderSummary.
  ///
  /// In ar, this message translates to:
  /// **'ملخص الطلب'**
  String get checkoutOrderSummary;

  /// No description provided for @checkoutBillingInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الفاتورة'**
  String get checkoutBillingInfo;

  /// No description provided for @checkoutPaymentMethod.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الدفع'**
  String get checkoutPaymentMethod;

  /// No description provided for @checkoutPayWithCard.
  ///
  /// In ar, this message translates to:
  /// **'بطاقة ائتمان / خصم'**
  String get checkoutPayWithCard;

  /// No description provided for @checkoutPayManual.
  ///
  /// In ar, this message translates to:
  /// **'دفع يدوي (تجريبي)'**
  String get checkoutPayManual;

  /// No description provided for @checkoutManualHint.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تعليم طلبك كمدفوع لأغراض التجربة.'**
  String get checkoutManualHint;

  /// No description provided for @checkoutFullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get checkoutFullName;

  /// No description provided for @checkoutEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get checkoutEmail;

  /// No description provided for @checkoutCardNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم البطاقة'**
  String get checkoutCardNumber;

  /// No description provided for @checkoutCardNumberHint.
  ///
  /// In ar, this message translates to:
  /// **'0000 0000 0000 0000'**
  String get checkoutCardNumberHint;

  /// No description provided for @checkoutExpiryDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الانتهاء'**
  String get checkoutExpiryDate;

  /// No description provided for @checkoutExpiryHint.
  ///
  /// In ar, this message translates to:
  /// **'MM/YY'**
  String get checkoutExpiryHint;

  /// No description provided for @checkoutCvv.
  ///
  /// In ar, this message translates to:
  /// **'CVV'**
  String get checkoutCvv;

  /// No description provided for @checkoutCvvHint.
  ///
  /// In ar, this message translates to:
  /// **'123'**
  String get checkoutCvvHint;

  /// No description provided for @checkoutCardholder.
  ///
  /// In ar, this message translates to:
  /// **'اسم حامل البطاقة'**
  String get checkoutCardholder;

  /// No description provided for @checkoutCardholderHint.
  ///
  /// In ar, this message translates to:
  /// **'الاسم على البطاقة'**
  String get checkoutCardholderHint;

  /// No description provided for @checkoutCouponCode.
  ///
  /// In ar, this message translates to:
  /// **'كود الخصم'**
  String get checkoutCouponCode;

  /// No description provided for @checkoutApply.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق'**
  String get checkoutApply;

  /// No description provided for @checkoutCouponApplied.
  ///
  /// In ar, this message translates to:
  /// **'تم تطبيق الكود.'**
  String get checkoutCouponApplied;

  /// No description provided for @checkoutCouponInvalid.
  ///
  /// In ar, this message translates to:
  /// **'كود الخصم غير صالح.'**
  String get checkoutCouponInvalid;

  /// No description provided for @checkoutSubtotal.
  ///
  /// In ar, this message translates to:
  /// **'المجموع الفرعي'**
  String get checkoutSubtotal;

  /// No description provided for @checkoutDiscount.
  ///
  /// In ar, this message translates to:
  /// **'الخصم'**
  String get checkoutDiscount;

  /// No description provided for @checkoutTax.
  ///
  /// In ar, this message translates to:
  /// **'الضريبة'**
  String get checkoutTax;

  /// No description provided for @checkoutTotal.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get checkoutTotal;

  /// No description provided for @checkoutPlaceOrder.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الطلب'**
  String get checkoutPlaceOrder;

  /// No description provided for @checkoutProcessing.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ المعالجة...'**
  String get checkoutProcessing;

  /// No description provided for @checkoutPaymentSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم الدفع بنجاح!'**
  String get checkoutPaymentSuccess;

  /// No description provided for @checkoutPaymentSuccessMessage.
  ///
  /// In ar, this message translates to:
  /// **'دوراتك متاحة الآن في \"تعلمي\".'**
  String get checkoutPaymentSuccessMessage;

  /// No description provided for @checkoutViewOrders.
  ///
  /// In ar, this message translates to:
  /// **'عرض الطلبات'**
  String get checkoutViewOrders;

  /// No description provided for @checkoutContinueShopping.
  ///
  /// In ar, this message translates to:
  /// **'متابعة التصفح'**
  String get checkoutContinueShopping;

  /// No description provided for @checkoutOrderFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إنشاء طلبك.'**
  String get checkoutOrderFailed;

  /// No description provided for @checkoutPaymentFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل الدفع. حاول مرة أخرى.'**
  String get checkoutPaymentFailed;

  /// No description provided for @checkoutRequired.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب.'**
  String get checkoutRequired;

  /// No description provided for @checkoutInvalidEmail.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدًا إلكترونيًا صالحًا.'**
  String get checkoutInvalidEmail;

  /// No description provided for @checkoutInvalidCard.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم بطاقة صالحًا.'**
  String get checkoutInvalidCard;

  /// No description provided for @checkoutInvalidExpiry.
  ///
  /// In ar, this message translates to:
  /// **'أدخل تاريخ انتهاء صالحًا.'**
  String get checkoutInvalidExpiry;

  /// No description provided for @checkoutInvalidCvv.
  ///
  /// In ar, this message translates to:
  /// **'أدخل CVV صالحًا.'**
  String get checkoutInvalidCvv;

  /// No description provided for @checkoutReadyForPayment.
  ///
  /// In ar, this message translates to:
  /// **'طلبك جاهز للدفع!'**
  String get checkoutReadyForPayment;

  /// No description provided for @checkoutReadyForPaymentHint.
  ///
  /// In ar, this message translates to:
  /// **'ادفع بأمان عبر Stripe لتفعيل دوراتك.'**
  String get checkoutReadyForPaymentHint;

  /// No description provided for @checkoutOrderNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الطلب'**
  String get checkoutOrderNumber;

  /// No description provided for @checkoutContinuePayment.
  ///
  /// In ar, this message translates to:
  /// **'متابعة الدفع'**
  String get checkoutContinuePayment;

  /// No description provided for @checkoutPaymentOpenFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر فتح صفحة الدفع.'**
  String get checkoutPaymentOpenFailed;

  /// No description provided for @orderHistoryOrderNumber.
  ///
  /// In ar, this message translates to:
  /// **'الطلب'**
  String get orderHistoryOrderNumber;

  /// No description provided for @orderHistoryDate.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get orderHistoryDate;

  /// No description provided for @orderHistoryItems.
  ///
  /// In ar, this message translates to:
  /// **'العناصر'**
  String get orderHistoryItems;

  /// No description provided for @orderHistoryTotal.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get orderHistoryTotal;

  /// No description provided for @orderHistoryStatus.
  ///
  /// In ar, this message translates to:
  /// **'الحالة'**
  String get orderHistoryStatus;

  /// No description provided for @orderHistoryStatusPending.
  ///
  /// In ar, this message translates to:
  /// **'قيد الانتظار'**
  String get orderHistoryStatusPending;

  /// No description provided for @orderHistoryStatusPaid.
  ///
  /// In ar, this message translates to:
  /// **'مدفوع'**
  String get orderHistoryStatusPaid;

  /// No description provided for @orderHistoryStatusFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل'**
  String get orderHistoryStatusFailed;

  /// No description provided for @orderHistoryStatusRefunded.
  ///
  /// In ar, this message translates to:
  /// **'مسترد'**
  String get orderHistoryStatusRefunded;

  /// No description provided for @orderHistoryStatusCancelled.
  ///
  /// In ar, this message translates to:
  /// **'ملغي'**
  String get orderHistoryStatusCancelled;

  /// No description provided for @orderHistorySearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في الطلبات...'**
  String get orderHistorySearchHint;

  /// No description provided for @orderHistoryLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل طلباتك.'**
  String get orderHistoryLoadFailed;

  /// No description provided for @orderHistoryItemsCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عناصر'**
  String orderHistoryItemsCount(Object count);

  /// No description provided for @certificatesIssuedOn.
  ///
  /// In ar, this message translates to:
  /// **'صدرت في'**
  String get certificatesIssuedOn;

  /// No description provided for @certificatesNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الشهادة'**
  String get certificatesNumber;

  /// No description provided for @certificatesDownload.
  ///
  /// In ar, this message translates to:
  /// **'تنزيل'**
  String get certificatesDownload;

  /// No description provided for @certificatesDownloading.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التنزيل...'**
  String get certificatesDownloading;

  /// No description provided for @certificatesDownloaded.
  ///
  /// In ar, this message translates to:
  /// **'تم تنزيل الشهادة.'**
  String get certificatesDownloaded;

  /// No description provided for @certificatesDownloadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تنزيل الشهادة.'**
  String get certificatesDownloadFailed;

  /// No description provided for @certificatesShare.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة'**
  String get certificatesShare;

  /// No description provided for @certificatesLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل شهاداتك.'**
  String get certificatesLoadFailed;

  /// No description provided for @notificationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notificationsTitle;

  /// No description provided for @notificationsToday.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get notificationsToday;

  /// No description provided for @notificationsEarlier.
  ///
  /// In ar, this message translates to:
  /// **'سابقًا'**
  String get notificationsEarlier;

  /// No description provided for @notificationsEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات بعد'**
  String get notificationsEmpty;

  /// No description provided for @notificationsEmptyHint.
  ///
  /// In ar, this message translates to:
  /// **'ستظهر تحديثات دوراتك هنا.'**
  String get notificationsEmptyHint;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In ar, this message translates to:
  /// **'تعليم الكل كمقروء'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل الإشعارات.'**
  String get notificationsLoadFailed;

  /// No description provided for @notificationsMarkReadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحديث الإشعار.'**
  String get notificationsMarkReadFailed;

  /// No description provided for @learningSettingsLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل إعداداتك.'**
  String get learningSettingsLoadFailed;

  /// No description provided for @learningSettingsSaveFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ إعداداتك.'**
  String get learningSettingsSaveFailed;

  /// No description provided for @preferencesLoadFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحميل تفضيلاتك.'**
  String get preferencesLoadFailed;

  /// No description provided for @preferencesSaveFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر حفظ تفضيلاتك.'**
  String get preferencesSaveFailed;

  /// No description provided for @preferencesEnglish.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get preferencesEnglish;

  /// No description provided for @preferencesArabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get preferencesArabic;

  /// No description provided for @preferencesThemeLight.
  ///
  /// In ar, this message translates to:
  /// **'فاتح'**
  String get preferencesThemeLight;

  /// No description provided for @preferencesThemeDark.
  ///
  /// In ar, this message translates to:
  /// **'داكن'**
  String get preferencesThemeDark;

  /// No description provided for @preferencesThemeSystem.
  ///
  /// In ar, this message translates to:
  /// **'النظام'**
  String get preferencesThemeSystem;

  /// No description provided for @contactUsSubject.
  ///
  /// In ar, this message translates to:
  /// **'الموضوع'**
  String get contactUsSubject;

  /// No description provided for @contactUsSubjectHint.
  ///
  /// In ar, this message translates to:
  /// **'كيف يمكننا مساعدتك؟'**
  String get contactUsSubjectHint;

  /// No description provided for @contactUsCategory.
  ///
  /// In ar, this message translates to:
  /// **'الفئة'**
  String get contactUsCategory;

  /// No description provided for @contactUsCategoryGeneral.
  ///
  /// In ar, this message translates to:
  /// **'عام'**
  String get contactUsCategoryGeneral;

  /// No description provided for @contactUsCategoryTechnical.
  ///
  /// In ar, this message translates to:
  /// **'تقني'**
  String get contactUsCategoryTechnical;

  /// No description provided for @contactUsCategoryBilling.
  ///
  /// In ar, this message translates to:
  /// **'الفواتير'**
  String get contactUsCategoryBilling;

  /// No description provided for @contactUsCategoryOther.
  ///
  /// In ar, this message translates to:
  /// **'أخرى'**
  String get contactUsCategoryOther;

  /// No description provided for @contactUsSendFailed.
  ///
  /// In ar, this message translates to:
  /// **'تعذر إرسال رسالتك.'**
  String get contactUsSendFailed;

  /// No description provided for @homeContinueLearning.
  ///
  /// In ar, this message translates to:
  /// **'متابعة التعلم'**
  String get homeContinueLearning;

  /// No description provided for @homeCurrentModule.
  ///
  /// In ar, this message translates to:
  /// **'الوحدة الحالية'**
  String get homeCurrentModule;

  /// No description provided for @homeTopCategories.
  ///
  /// In ar, this message translates to:
  /// **'أهم التصنيفات'**
  String get homeTopCategories;

  /// No description provided for @homeSeeAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get homeSeeAll;

  /// No description provided for @homeRecommended.
  ///
  /// In ar, this message translates to:
  /// **'دورات مقترحة'**
  String get homeRecommended;

  /// No description provided for @homeRecommendedSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'دورات مختارة لرحلتك التعليمية'**
  String get homeRecommendedSubtitle;

  /// No description provided for @homeWelcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بعودتك'**
  String get homeWelcome;

  /// No description provided for @homeHeroTitle.
  ///
  /// In ar, this message translates to:
  /// **'اكتسب مهارات جديدة\nمع مدربين خبراء'**
  String get homeHeroTitle;

  /// No description provided for @homeResume.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get homeResume;

  /// No description provided for @homeCompletedPercent.
  ///
  /// In ar, this message translates to:
  /// **'{percent}% مكتمل'**
  String homeCompletedPercent(Object percent);

  /// No description provided for @homeNoContinue.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك أي دورة قيد التقدم.'**
  String get homeNoContinue;

  /// No description provided for @homeViewCourse.
  ///
  /// In ar, this message translates to:
  /// **'عرض الدورة'**
  String get homeViewCourse;

  /// No description provided for @settingsManageDescription.
  ///
  /// In ar, this message translates to:
  /// **'أدر تفضيلات حسابك وبياناتك الشخصية وتخصيص التطبيق من هنا.'**
  String get settingsManageDescription;

  /// No description provided for @settingsProfileInfoTitle.
  ///
  /// In ar, this message translates to:
  /// **'معلومات الملف الشخصي'**
  String get settingsProfileInfoTitle;

  /// No description provided for @settingsProfileInfoDescription.
  ///
  /// In ar, this message translates to:
  /// **'عدّل اسمك وصورتك الشخصية وبريدك الإلكتروني.'**
  String get settingsProfileInfoDescription;

  /// No description provided for @settingsLearningTitle.
  ///
  /// In ar, this message translates to:
  /// **'التعلم والشهادات'**
  String get settingsLearningTitle;

  /// No description provided for @settingsLearningDescription.
  ///
  /// In ar, this message translates to:
  /// **'اسم مستلم الشهادة وهدف التعلم والمجال المهني.'**
  String get settingsLearningDescription;

  /// No description provided for @settingsSecurityTitle.
  ///
  /// In ar, this message translates to:
  /// **'الأمان'**
  String get settingsSecurityTitle;

  /// No description provided for @settingsSecurityDescription.
  ///
  /// In ar, this message translates to:
  /// **'تحديث كلمة مرور حسابك.'**
  String get settingsSecurityDescription;

  /// No description provided for @settingsPreferencesTitle.
  ///
  /// In ar, this message translates to:
  /// **'التفضيلات'**
  String get settingsPreferencesTitle;

  /// No description provided for @settingsPreferencesDescription.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات ولغة التطبيق والمظهر.'**
  String get settingsPreferencesDescription;

  /// No description provided for @dashboardOverview.
  ///
  /// In ar, this message translates to:
  /// **'نظرة عامة على لوحة الطالب'**
  String get dashboardOverview;

  /// No description provided for @dashboardWelcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بعودتك، {name}'**
  String dashboardWelcome(Object name);

  /// No description provided for @browseCoursesSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'واصل رحلتك التعليمية'**
  String get browseCoursesSubtitle;

  /// No description provided for @browseCourseProgress.
  ///
  /// In ar, this message translates to:
  /// **'التقدم'**
  String get browseCourseProgress;

  /// No description provided for @browseViewCertificate.
  ///
  /// In ar, this message translates to:
  /// **'عرض الشهادة'**
  String get browseViewCertificate;

  /// No description provided for @browseBack.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get browseBack;

  /// No description provided for @settingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الطالب'**
  String get settingsTitle;

  /// No description provided for @profileActive.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get profileActive;

  /// No description provided for @homeCategoryCourses.
  ///
  /// In ar, this message translates to:
  /// **'دورات'**
  String get homeCategoryCourses;

  /// No description provided for @certificatesStudentName.
  ///
  /// In ar, this message translates to:
  /// **'الطالب'**
  String get certificatesStudentName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
