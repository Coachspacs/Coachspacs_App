/// Holds the current UI language code used for the `Accept-Language` header.
///
/// The backend localizes category names (and other localized strings) server-
/// side from `Accept-Language` via `LocaleMiddleware`. The mobile app defaults
/// to `en`; when runtime AR/EN switching lands, update [code] from the app's
/// locale (e.g. in `MaterialApp.locale` or the locale cubit) so every request
/// carries the correct language without touching the networking layer.
abstract final class AppLanguage {
  static String code = 'en';
}
