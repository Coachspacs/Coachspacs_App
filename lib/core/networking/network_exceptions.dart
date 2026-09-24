import 'package:dio/dio.dart';

/// Failure categories mapped from HTTP status codes / transport errors.
enum FailureKind {
  /// `400` — validation/field-level errors.
  validation,

  /// `401` — missing/expired/invalid token (after refresh attempts).
  unauthorized,

  /// `403` — authenticated but not permitted (e.g. pending approval).
  forbidden,

  /// `404` — resource not found.
  notFound,

  /// `409` — conflict (e.g. already enrolled).
  conflict,

  /// `422` — business-rule rejection.
  businessRejection,

  /// `429` — rate limited.
  rateLimited,

  /// `5xx` — server error.
  serverError,

  /// Timeout / connection lost / no network.
  offline,

  /// Anything else.
  unknown,
}

/// Typed application failure produced at the API boundary.
class NetworkException implements Exception {
  const NetworkException({
    required this.kind,
    required this.message,
    this.fieldErrors = const {},
  });

  /// Fallback message used when no more specific text is available.
  static const String fallbackMessage = 'حدث خطأ، حاول مرة أخرى';

  final FailureKind kind;
  final String message;
  final Map<String, List<String>> fieldErrors;

  /// Maps a [DioException] to a typed, user-displayable failure.
  ///
  /// Supports DRF's `{"detail": "..."}` / `{"field_errors": {...}}` formats,
  /// Django's `{"field": ["..."]}` format, and plain messages.
  factory NetworkException.fromDioException(DioException error) {
    const fallback = NetworkException.fallbackMessage;

    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkException(
          kind: FailureKind.offline,
          message: 'تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت',
        );
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        break;
    }

    final status = error.response?.statusCode;
    if (status == null) {
      return const NetworkException(
        kind: FailureKind.unknown,
        message: fallback,
      );
    }
    final data = error.response?.data;

    final (message, fieldErrors) = _parseBody(data, fallback);

    final kind = switch (status) {
      400 => FailureKind.validation,
      401 => FailureKind.unauthorized,
      403 => FailureKind.forbidden,
      404 => FailureKind.notFound,
      409 => FailureKind.conflict,
      422 => FailureKind.businessRejection,
      429 => FailureKind.rateLimited,
      >= 500 => FailureKind.serverError,
      _ => FailureKind.unknown,
    };

    return NetworkException(
      kind: kind,
      message: message,
      fieldErrors: fieldErrors,
    );
  }

  /// Wraps [request] so transport *and* response-deserialization failures
  /// surface as [NetworkException].
  ///
  /// Retrofit parses the body after Dio resolves; a null/missing field the
  /// DTO expects throws a raw [TypeError]/[FormatException] that would
  /// otherwise bypass per-repository `on DioException` handling and fall
  /// into cubits' generic `catch (_)` (blank "something went wrong" state).
  static Future<T> guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    } on TypeError {
      throw const NetworkException(
        kind: FailureKind.unknown,
        message: fallbackMessage,
      );
    } on FormatException {
      throw const NetworkException(
        kind: FailureKind.unknown,
        message: fallbackMessage,
      );
    }
  }

  static (String, Map<String, List<String>>) _parseBody(
    Object? data,
    String fallback,
  ) {
    if (data is! Map<String, dynamic>) return (fallback, const {});

    final detail = data['detail'];
    if (detail is String && detail.isNotEmpty) return (detail, const {});

    final fieldErrors = <String, List<String>>{};
    for (final entry in data.entries) {
      final value = entry.value;
      if (value is List) {
        fieldErrors[entry.key] = value.map((e) => e.toString()).toList();
      } else if (value is String) {
        fieldErrors[entry.key] = [value];
      }
    }
    if (fieldErrors.isNotEmpty) {
      final first = fieldErrors.values.firstWhere(
        (list) => list.isNotEmpty,
        orElse: () => const [],
      );
      return (first.isNotEmpty ? first.first : fallback, fieldErrors);
    }

    return (fallback, const {});
  }
}
