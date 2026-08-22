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
  /// **'تحقق من بريدك الإلكتروني'**
  String get emailVerificationTitle;

  /// First part of the verification body text
  ///
  /// In ar, this message translates to:
  /// **'لقد أرسلنا رابط التحقق إلى '**
  String get emailVerificationBodyPrefix;

  /// Second part of the verification body text
  ///
  /// In ar, this message translates to:
  /// **'. اضغط على الرابط في بريدك الإلكتروني لتفعيل حسابك.'**
  String get emailVerificationBodySuffix;

  /// Open email button
  ///
  /// In ar, this message translates to:
  /// **'فتح البريد الإلكتروني'**
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
  /// **'إعادة الإرسال ({time})'**
  String emailVerificationResendCountdown(String time);

  /// Success message after resending the link
  ///
  /// In ar, this message translates to:
  /// **'تم إعادة إرسال رابط التحقق'**
  String get emailVerificationResent;

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
