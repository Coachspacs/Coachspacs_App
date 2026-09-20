/// `GET /api/certificates/verify/{code}` response body (US-18).
///
/// Public, unauthenticated and read-only. The OpenAPI document does not pin
/// down the payload, so parsing is lenient: `valid` is either explicit or
/// inferred from the HTTP 200/404 the server returns. A malformed code is
/// rejected by the server with 400 before this DTO is ever built.
class CertificateVerifyDto {
  const CertificateVerifyDto({
    required this.isValid,
    this.code,
    this.studentName,
    this.courseTitle,
    this.issuedAt,
    this.message,
  });

  final bool isValid;
  final String? code;
  final String? studentName;
  final String? courseTitle;
  final String? issuedAt;
  final String? message;

  factory CertificateVerifyDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    bool parseValid(Object? raw) {
      if (raw is bool) return raw;
      if (raw is String) return raw.toLowerCase() == 'true' || raw == '1';
      if (raw is num) return raw != 0;
      return false;
    }

    final valid = parseValid(first(const ['valid', 'is_valid', 'found']));

    return CertificateVerifyDto(
      isValid: valid,
      code: first(const ['code', 'certificate_code', 'certificate'])?.toString(),
      studentName: first(const [
        'student_name',
        'full_name',
        'owner',
        'holder',
      ])?.toString(),
      courseTitle: first(const ['course_title', 'course', 'title'])?.toString(),
      issuedAt: first(const ['issued_at', 'issued_on', 'date'])?.toString(),
      message: first(const ['message', 'detail'])?.toString(),
    );
  }
}

/// HTTP 404 body used when the code is well-formed but unrecognised.
class CertificateVerifyNotFoundDto {
  const CertificateVerifyNotFoundDto({this.message, this.code});

  final String? message;
  final String? code;

  factory CertificateVerifyNotFoundDto.fromJson(Map<String, dynamic> json) {
    return CertificateVerifyNotFoundDto(
      message: json['message']?.toString() ?? json['detail']?.toString(),
      code: json['code']?.toString(),
    );
  }
}