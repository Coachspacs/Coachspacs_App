import 'package:dio/dio.dart';

import 'app_language.dart';

/// Adds `Accept-Language` so the backend returns localized strings (category
/// names, etc.) matching the app's current locale.
///
/// Reads [AppLanguage.code] on every request — no restart required when the
/// language changes at runtime.
class AcceptLanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final code = AppLanguage.code;
    if (code.isNotEmpty) {
      options.headers['Accept-Language'] = code;
    }
    handler.next(options);
  }
}
