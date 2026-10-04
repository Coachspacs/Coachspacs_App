/// `GET /api/ai/roadmap` response (US-18).
///
/// The OpenAPI document does not pin down the response schema, so parsing is
/// lenient: `{"path": null}` means the student has no active path yet (the
/// cue to show the My Path wizard), and every field is looked up under its
/// snake_case/camelCase candidates.
class RoadmapResponseDto {
  const RoadmapResponseDto({required this.path});

  /// The active learning path, or null when none has been generated yet.
  final RoadmapDto? path;

  factory RoadmapResponseDto.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return const RoadmapResponseDto(path: null);

    final raw = json['path'] ?? json['roadmap'];
    if (raw is Map<String, dynamic>) {
      return RoadmapResponseDto(path: RoadmapDto.fromJson(raw));
    }
    // Some serializers return the path object directly instead of wrapping it.
    if (json['steps'] is List) {
      return RoadmapResponseDto(path: RoadmapDto.fromJson(json));
    }
    return const RoadmapResponseDto(path: null);
  }
}

class RoadmapDto {
  const RoadmapDto({
    this.id,
    this.category,
    this.categoryName,
    this.goalText,
    this.currentLevel,
    this.weeklyHours,
    this.status,
    this.steps = const [],
  });

  final int? id;

  /// Raw category reference kept for compatibility — may be an id string.
  final String? category;

  /// Human-readable category name from the nested `goal` object, e.g.
  /// "Digital Marketing".
  final String? categoryName;
  final String? goalText;

  /// `beginner` | `basic` | `intermediate` | `advanced`.
  final String? currentLevel;

  /// Weekly study hours the path was generated around, e.g. `12`.
  final String? weeklyHours;

  /// `active` while the path is live for this student.
  final String? status;

  /// Steps keyed by [RoadmapStepDto.order] (1-based).
  final List<RoadmapStepDto> steps;

  factory RoadmapDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    final rawSteps = json['steps'];
    final steps = rawSteps is List
        ? rawSteps
              .whereType<Map<String, dynamic>>()
              .map(RoadmapStepDto.fromJson)
              .toList()
        : const <RoadmapStepDto>[];

    // The live API nests the wizard inputs under `goal`; older payloads put
    // them at the top level — read both.
    final rawGoal = json['goal'];
    final goalJson = rawGoal is Map<String, dynamic>
        ? rawGoal
        : const <String, dynamic>{};
    final rawCategory = goalJson['category'];
    final categoryName = switch (rawCategory) {
      Map<String, dynamic> cat => (cat['name'] ?? cat['title'])?.toString(),
      _ => first(const ['category_name', 'categoryName'])?.toString(),
    };

    Object? goalOrTop(List<String> goalKeys, List<String> topKeys) =>
        goalJson[goalKeys.first] ?? first(topKeys);

    final weeklyRaw = goalOrTop(
      const ['weekly_hours'],
      const ['weekly_hours', 'weeklyHours'],
    );

    return RoadmapDto(
      id: switch (first(const ['id'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value),
        _ => null,
      },
      category: first(const ['category'])?.toString(),
      categoryName: categoryName,
      goalText: goalOrTop(
        const ['goal_text'],
        const ['goal_text', 'goalText'],
      )?.toString(),
      currentLevel: goalOrTop(
        const ['current_level'],
        const ['current_level', 'currentLevel'],
      )?.toString(),
      weeklyHours: weeklyRaw == null
          ? null
          : switch (weeklyRaw) {
              num value => value
                  .toString()
                  .replaceFirst(RegExp(r'\.0$'), ''),
              _ => weeklyRaw.toString(),
            },
      status: first(const ['status'])?.toString(),
      steps: steps,
    );
  }

  RoadmapDto copyWith({List<RoadmapStepDto>? steps, String? status}) {
    return RoadmapDto(
      id: id,
      category: category,
      categoryName: categoryName,
      goalText: goalText,
      currentLevel: currentLevel,
      weeklyHours: weeklyHours,
      status: status ?? this.status,
      steps: steps ?? this.steps,
    );
  }

  /// Steps sorted by their 1-based server order.
  List<RoadmapStepDto> get orderedSteps {
    final sorted = [...steps]..sort(
        (a, b) => (a.order ?? a.id).compareTo(b.order ?? b.id),
      );
    return sorted;
  }

  /// Steps counted as milestones (part of the progression rail).
  int get totalSteps => steps.length;

  int get completedSteps =>
      steps.where((s) => s.isCompleted).length;

  double get progressPercent =>
      totalSteps == 0 ? 0 : (completedSteps / totalSteps) * 100;

  /// Index (in [orderedSteps]) of the milestone the student should work on
  /// now: the first that is neither completed nor skipped. Falls back to the
  /// last step so the trophy stays reachable.
  int get currentActiveIndex {
    final ordered = orderedSteps;
    if (ordered.isEmpty) return 0;
    final firstOpen = ordered.indexWhere(
      (s) => !s.isCompleted && !s.isSkipped,
    );
    return firstOpen == -1 ? ordered.length - 1 : firstOpen;
  }
}

class RoadmapStepDto {
  const RoadmapStepDto({
    required this.id,
    this.order,
    this.title,
    this.reason,
    this.courseTitle,
    this.courseId,
    this.courseDescription,
    this.instructorName,
    this.durationHours = 8,
    this.isCourseFree,
    this.status,
  });

  final int id;
  final int? order;
  final String? title;
  final String? reason;
  final String? courseTitle;
  final int? courseId;
  final String? courseDescription;
  final String? instructorName;

  /// Server omits course duration sometimes; the web client falls back to 8h.
  final int durationHours;
  final bool? isCourseFree;

  /// `pending` | `in_progress` | `completed`/`done` | `skipped` (server vocabulary).
  final String? status;

  bool get isCompleted =>
      status == 'completed' || status == 'done';

  bool get isSkipped => status == 'skipped';

  bool get isInProgress =>
      status == 'in_progress' || status == 'started';

  factory RoadmapStepDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    final rawCourse = json['course'];
    final courseId = switch (rawCourse) {
      int value => value,
      num value => value.toInt(),
      String value => int.tryParse(value),
      Map<String, dynamic> course => switch (course['id']) {
          int value => value,
          num value => value.toInt(),
          _ => null,
        },
      _ => null,
    };

    final courseTitle =
        (first(const ['course_title', 'courseTitle']) ?? (rawCourse is Map ? rawCourse['title'] : null))
            ?.toString();
    final courseJson = rawCourse is Map<String, dynamic>
        ? rawCourse
        : const <String, dynamic>{};
    final rawInstructor = courseJson['instructor'];
    final instructorName = switch (rawInstructor) {
      Map<String, dynamic> inst =>
        (inst['full_name'] ?? inst['name'])?.toString(),
      _ => (first(const ['instructor_name', 'instructorName']) ??
          courseJson['instructor'])
          ?.toString(),
    };

    return RoadmapStepDto(
      id: switch (first(const ['id'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value) ?? 0,
        _ => 0,
      },
      order: switch (first(const ['order', 'position'])) {
        int value => value,
        num value => value.toInt(),
        String value => int.tryParse(value),
        _ => null,
      },
      title: (first(const ['title', 'name']) ?? courseTitle)?.toString(),
      reason: first(const ['reason', 'why'])?.toString(),
      courseTitle: courseTitle,
      courseId: courseId,
      courseDescription: (first(const ['course_description', 'courseDescription']) ??
              courseJson['description'])
          ?.toString(),
      instructorName: instructorName,
      durationHours: switch (courseJson['duration_hours'] ??
          courseJson['duration'] ??
          first(const ['duration_hours', 'durationHours'])) {
        num value => value.toInt(),
        String value => int.tryParse(value) ?? 8,
        _ => 8,
      },
      isCourseFree: switch (first(const ['is_free', 'isFree'])) {
        bool value => value,
        String value => value.toLowerCase() == 'true',
        _ => null,
      },
      status: first(const ['status', 'step_status'])?.toString(),
    );
  }

  RoadmapStepDto copyWith({String? status, int? order}) {
    return RoadmapStepDto(
      id: id,
      order: order ?? this.order,
      title: title,
      reason: reason,
      courseTitle: courseTitle,
      courseId: courseId,
      courseDescription: courseDescription,
      instructorName: instructorName,
      durationHours: durationHours,
      isCourseFree: isCourseFree,
      status: status ?? this.status,
    );
  }
}

/// `POST /api/ai/roadmap/generate` body — `category`/`goal_text` are
/// optional; `current_level` and `weekly_hours` are required.
class RoadmapGenerateRequest {
  const RoadmapGenerateRequest({
    this.category,
    this.goalText,
    required this.currentLevel,
    required this.weeklyHours,
  });

  final String? category;
  final String? goalText;
  final String currentLevel;
  final String weeklyHours;

  Map<String, dynamic> toJson() => {
        if (category != null) 'category': category,
        if (goalText != null) 'goal_text': goalText,
        'current_level': currentLevel,
        'weekly_hours': weeklyHours,
      };
}

/// `POST /api/ai/roadmap/regenerate` body — only the changed inputs are
/// sent; whatever is omitted is carried over from the latest goal.
class RoadmapRegenerateRequest {
  const RoadmapRegenerateRequest({
    this.category,
    this.goalText,
    this.currentLevel,
    this.weeklyHours,
  });

  final String? category;
  final String? goalText;
  final String? currentLevel;
  final String? weeklyHours;

  Map<String, dynamic> toJson() => {
        if (category != null) 'category': category,
        if (goalText != null) 'goal_text': goalText,
        if (currentLevel != null) 'current_level': currentLevel,
        if (weeklyHours != null) 'weekly_hours': weeklyHours,
      };
}

/// `PATCH /api/ai/roadmap/steps/{id}` body.
class RoadmapStepUpdateRequest {
  const RoadmapStepUpdateRequest({this.status, this.order});

  /// `skipped` | `pending`.
  final String? status;
  final int? order;

  Map<String, dynamic> toJson() => {
        if (status != null) 'status': status,
        if (order != null) 'order': order,
      };
}
