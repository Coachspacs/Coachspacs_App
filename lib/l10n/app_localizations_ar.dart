// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Coach Space';

  @override
  String get homeSearchHint => 'ابحث عن دورات، مدربين...';

  @override
  String get homeAll => 'الكل';

  @override
  String get homeFeatured => 'دورات مميزة';

  @override
  String get homeTrending => 'رائج الآن';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeEmptyTitle => 'لا يوجد محتوى بعد';

  @override
  String get homeEmptySubtitle => 'ستظهر الدورات الجديدة هنا.';

  @override
  String get homeErrorTitle => 'حدث خطأ ما';

  @override
  String get homeErrorSubtitle => 'تعذر تحميل المحتوى. حاول مرة أخرى.';

  @override
  String get homeOfflineTitle => 'أنت غير متصل';

  @override
  String get homeOfflineSubtitle => 'اتصل بالإنترنت لاستكشاف الدورات.';

  @override
  String get homeRetry => 'إعادة المحاولة';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navCourses => 'الدورات';

  @override
  String get navSearch => 'بحث';

  @override
  String get navProfile => 'الملف الشخصي';
}
