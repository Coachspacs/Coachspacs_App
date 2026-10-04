/// `GET /api/lessons/{id}/summary` response (US-19).
///
/// The response schema is not pinned down by the OpenAPI document, so parsing
/// is lenient. The language follows the request's Accept-Language header.
class LessonSummaryDto {
  const LessonSummaryDto({
    required this.summary,
    this.keyPoints = const [],
    this.language,
  });

  final String summary;
  final List<String> keyPoints;
  final String? language;

  factory LessonSummaryDto.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return const LessonSummaryDto(summary: '');

    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    final rawPoints = json['key_points'] ?? json['keyPoints'] ?? json['bullets'];
    final keyPoints = rawPoints is List
        ? rawPoints.map((point) => point?.toString() ?? '').toList()
        : const <String>[];

    return LessonSummaryDto(
      summary: (first(const ['summary', 'text', 'content', 'summary_text']) ?? '')
          .toString(),
      keyPoints: keyPoints,
      language: first(const ['language', 'lang'])?.toString(),
    );
  }
}
