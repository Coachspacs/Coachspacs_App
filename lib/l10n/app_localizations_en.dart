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
  String get homeSearchHint => 'Search for courses, instructors...';

  @override
  String get homeAll => 'All';

  @override
  String get homeFeatured => 'Featured Courses';

  @override
  String get homeTrending => 'Trending Now';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeEmptyTitle => 'Nothing here yet';

  @override
  String get homeEmptySubtitle => 'New courses will show up here.';

  @override
  String get homeErrorTitle => 'Something went wrong';

  @override
  String get homeErrorSubtitle =>
      'We couldn\'t load content. Please try again.';

  @override
  String get homeOfflineTitle => 'You\'re offline';

  @override
  String get homeOfflineSubtitle =>
      'Connect to the internet to explore courses.';

  @override
  String get homeRetry => 'Retry';

  @override
  String get navHome => 'Home';

  @override
  String get navCourses => 'Courses';

  @override
  String get navSearch => 'Search';

  @override
  String get navProfile => 'Profile';
}
