import 'package:dio/dio.dart';

import 'package:coach_space/core/storage/session_storage.dart';

/// Injects the short-lived access token and transparently refreshes on 401.
///
/// Simple JWT contract:
/// - Every request carries `Authorization: Bearer <access>`.
/// - On `401` the client refreshes once via `/api/auth/refresh` and retries.
/// - If no refresh token exists (e.g. the login request itself) or refresh
///   fails, the error propagates so the caller can prompt for login.
///
/// The refresh path is deliberately interceptor-free to prevent recursive
/// refresh loops; concurrent 401s share a single in-flight refresh.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this._sessionStorage,
    this._client, [
    this._refreshPath = 'api/auth/refresh',
  ]);

  final SessionStorage _sessionStorage;
  final Dio Function() _client;
  final String _refreshPath;

  Future<String?>? _refreshInFlight;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _sessionStorage.readAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    final hadAuth = err.requestOptions.headers.containsKey('Authorization');
    if (status != 401 || !hadAuth) {
      handler.next(err);
      return;
    }

    try {
      final accessToken = await _refreshAccessToken();
      if (accessToken == null) {
        handler.next(err);
        return;
      }

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $accessToken';
      final response = await _client().fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } on DioException catch (refreshError) {
      await _sessionStorage.clear();
      handler.next(refreshError);
    }
  }

  Future<String?> _refreshAccessToken() {
    final inFlight = _refreshInFlight;
    if (inFlight != null) return inFlight;

    final future = _doRefresh();
    _refreshInFlight = future;
    return future.whenComplete(() => _refreshInFlight = null);
  }

  Future<String?> _doRefresh() async {
    final refreshToken = await _sessionStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;

    // Interceptor-free client sharing the main transport: the refresh request
    // never triggers another refresh and never carries the stale bearer token.
    final response = await _plainDio().post<Map<String, dynamic>>(
      _refreshPath,
      data: {'refresh': refreshToken},
    );
    final data = response.data ?? <String, dynamic>{};
    final newAccess = data['access']?.toString() ?? '';
    final rotatedRefresh = data['refresh']?.toString();

    if (newAccess.isEmpty) return null;

    await _sessionStorage.updateTokens(
      access: newAccess,
      refresh: rotatedRefresh,
    );
    return newAccess;
  }

  Dio _plainDio() {
    final base = _client();
    return Dio(base.options.copyWith())
      ..httpClientAdapter = base.httpClientAdapter;
  }
}
