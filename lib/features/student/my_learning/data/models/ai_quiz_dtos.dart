/// AI practice quizzes (`/api/courses/{id}/ai-quizzes`, `/api/ai-quizzes`).
///
/// Generation is asynchronous: the start endpoint answers 202 with a pending
/// quiz and the client polls `GET /api/ai-quizzes/{id}` until `ready` or
/// `failed`. The OpenAPI document does not pin down every nested schema, so
/// parsing is lenient with multi-candidate keys.
class AIQuizDto {
  const AIQuizDto({
    required this.id,
    this.courseId,
    this.language,
    this.questionCount,
    this.sourceType,
    this.isGeneral,
    this.notice,
    required this.status,
    this.detail,
    this.createdAt,
    this.latestAttempt,
    this.questions = const [],
  });

  final int id;
  final int? courseId;
  final String? language;
  final int? questionCount;
  final String? sourceType;
  final bool? isGeneral;
  final String? notice;

  /// `pending` while generating, `ready` once questions exist, `failed` if
  /// generation could not produce a quiz.
  final String status;
  final String? detail;
  final DateTime? createdAt;
  final String? latestAttempt;
  final List<AIQuizQuestionDto> questions;

  bool get isReady => status == 'ready';
  bool get isPending => status == 'pending';
  bool get isFailed => status == 'failed';
  bool get hasQuestions => questions.isNotEmpty;

  factory AIQuizDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    final rawQuestions = json['questions'];
    final questions = rawQuestions is List
        ? rawQuestions
              .whereType<Map<String, dynamic>>()
              .map(AIQuizQuestionDto.fromJson)
              .toList()
        : const <AIQuizQuestionDto>[];

    return AIQuizDto(
      id: switch (first(const ['id'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value) ?? 0,
        _ => 0,
      },
      courseId: switch (first(const ['course', 'course_id'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value),
        _ => null,
      },
      language: first(const ['language'])?.toString(),
      questionCount: switch (first(const ['question_count', 'questionCount'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value),
        _ => null,
      },
      sourceType: first(const ['source_type', 'sourceType'])?.toString(),
      isGeneral: switch (first(const ['is_general', 'isGeneral'])) {
        bool value => value,
        String value => value == 'true',
        _ => null,
      },
      notice: first(const ['notice'])?.toString(),
      status: first(const ['status'])?.toString() ?? 'pending',
      detail: first(const ['detail'])?.toString(),
      createdAt: switch (first(const ['created_at', 'createdAt'])) {
        String value => DateTime.tryParse(value),
        _ => null,
      },
      latestAttempt: first(const ['latest_attempt', 'latestAttempt'])?.toString(),
      questions: questions,
    );
  }
}

class AIQuizQuestionDto {
  const AIQuizQuestionDto({
    required this.id,
    required this.prompt,
    required this.options,
    this.kind,
  });

  final int id;
  final String prompt;

  /// Ordered options; the student's answer is submitted as an index into
  /// this list. For true/false questions this is `['False', 'True']`.
  final List<String> options;
  final String? kind;

  factory AIQuizQuestionDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    final rawOptions = json['options'];
    final options = rawOptions is List
        ? rawOptions
            .map((option) => switch (option) {
                  String value => value,
                  Map<String, dynamic> map =>
                    (map['text'] ?? map['label'] ?? map['value'] ?? '')
                        .toString(),
                  _ => option?.toString() ?? '',
                })
            .toList()
        : const <String>[];

    return AIQuizQuestionDto(
      id: switch (first(const ['id'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value) ?? 0,
        _ => 0,
      },
      prompt: (first(const ['question', 'prompt', 'text']) ?? '').toString(),
      options: options,
      kind: first(const ['kind', 'type', 'question_type'])?.toString(),
    );
  }
}

/// `POST /api/ai-quizzes/{id}/submit` body — `selected_answer` is the option
/// index; a question left out counts as wrong.
class AIQuizSubmitRequest {
  const AIQuizSubmitRequest({required this.answers});

  final List<AIQuizAnswer> answers;

  Map<String, dynamic> toJson() => {
        'answers': answers.map((answer) => answer.toJson()).toList(),
      };
}

class AIQuizAnswer {
  const AIQuizAnswer({required this.questionId, required this.selectedAnswer});

  final int questionId;
  final int selectedAnswer;

  Map<String, dynamic> toJson() => {
        'question_id': questionId,
        'selected_answer': selectedAnswer,
      };
}

/// `POST /api/ai-quizzes/{id}/submit` response — the only response that
/// reveals correct answers and explanations. Schema unspecified; lenient.
class AIQuizResultDto {
  const AIQuizResultDto({
    this.score,
    this.correctCount,
    this.totalCount,
    this.results = const [],
  });

  final num? score;
  final int? correctCount;
  final int? totalCount;
  final List<AIQuizAnswerResultDto> results;

  factory AIQuizResultDto.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return const AIQuizResultDto();

    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    final rawResults = json['results'] ?? json['answers'] ?? json['details'];
    final results = rawResults is List
        ? rawResults
              .whereType<Map<String, dynamic>>()
              .map(AIQuizAnswerResultDto.fromJson)
              .toList()
        : const <AIQuizAnswerResultDto>[];

    return AIQuizResultDto(
      score: switch (first(const ['score', 'percent', 'percentage'])) {
        int value => value,
        num value => value,
        String value => num.tryParse(value),
        _ => null,
      },
      correctCount: switch (first(const ['correct_count', 'correctCount'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value),
        _ => null,
      },
      totalCount: switch (first(const ['total', 'total_count', 'totalCount'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value),
        _ => null,
      },
      results: results,
    );
  }
}

class AIQuizAnswerResultDto {
  const AIQuizAnswerResultDto({
    required this.questionId,
    this.selectedAnswer,
    this.correctAnswer,
    required this.isCorrect,
    this.explanation,
  });

  final int questionId;
  final int? selectedAnswer;
  final int? correctAnswer;
  final bool isCorrect;
  final String? explanation;

  factory AIQuizAnswerResultDto.fromJson(Map<String, dynamic> json) {
    int? asInt(Object? value) => switch (value) {
          int value => value,
          num value => value.toInt(),
          String value => int.tryParse(value),
          _ => null,
        };

    return AIQuizAnswerResultDto(
      questionId: asInt(json['question_id'] ?? json['questionId'] ?? json['id']) ?? 0,
      selectedAnswer: asInt(json['selected_answer'] ?? json['selectedAnswer']),
      correctAnswer: asInt(
        json['correct_answer'] ?? json['correctAnswer'] ?? json['answer'],
      ),
      isCorrect: switch (json['is_correct'] ?? json['isCorrect'] ?? json['correct']) {
        bool value => value,
        String value => value == 'true',
        _ => false,
      },
      explanation:
          (json['explanation'] ?? json['rationale'] ?? json['why'])?.toString(),
    );
  }
}

/// `POST /api/courses/{id}/ai-quizzes` body — keys are not pinned down by
/// the document; `lesson_ids`/`question_count`/`language` are the natural
/// candidates and unknown ones are ignored server-side.
class AIQuizStartRequest {
  const AIQuizStartRequest({this.lessonIds, this.questionCount, this.language});

  final List<int>? lessonIds;
  final int? questionCount;
  final String? language;

  Map<String, dynamic> toJson() => {
        if (lessonIds != null && lessonIds!.isNotEmpty)
          'lesson_ids': lessonIds,
        if (questionCount != null) 'question_count': questionCount,
        if (language != null) 'language': language,
      };
}
