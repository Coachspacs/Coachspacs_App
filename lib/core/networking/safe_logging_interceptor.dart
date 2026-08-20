import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Debug-only request/response logger.
///
/// Logs method, path and status code — never request/response bodies, never
/// headers (which would leak the `Authorization: Bearer` token) and never
/// query parameters that could carry verification tokens.
class SafeLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('DIO ⟶ ${options.method} ${options.path}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint(
        'DIO ⟵ ${response.requestOptions.method} '
        '${response.requestOptions.path} ${response.statusCode}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'DIO ✗ ${err.requestOptions.method} ${err.requestOptions.path} '
        '${err.response?.statusCode} (${err.type.name})',
      );
    }
    handler.next(err);
  }
}
