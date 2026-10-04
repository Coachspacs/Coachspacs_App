import 'package:equatable/equatable.dart';

import '../../data/models/my_path_models.dart';
import '../../data/models/roadmap_dtos.dart';

enum MyPathStatus { notStarted, inProgress, completed }

class MyPathState extends Equatable {
  final MyPathOption? goal;
  final MyPathOption? level;
  final MyPathSkillOption? skill;
  final MyPathOption? hours;

  /// The active path on the server, if one has been generated. Null while the
  /// student is still in the wizard (or when generation has not succeeded).
  final RoadmapDto? roadmap;
  final MyPathStatus status;

  /// True while the initially active path is still being fetched (or being
  /// generated after the wizard finishes) — the hub screens show a loading
  /// placeholder instead of flashing the wizard.
  final bool roadmapLoading;

  /// Course ids the student is already enrolled in, used to switch roadmap
  /// milestone buttons between "Enroll & Purchase" and "Start Learning".
  final Set<int> enrolledCourseIds;

  const MyPathState({
    this.goal,
    this.level,
    this.skill,
    this.hours,
    this.roadmap,
    this.status = MyPathStatus.notStarted,
    this.roadmapLoading = false,
    this.enrolledCourseIds = const {},
  });

  int get completedSteps =>
      (goal != null ? 1 : 0) +
      (level != null ? 1 : 0) +
      (skill != null ? 1 : 0) +
      (hours != null ? 1 : 0);

  double get progress =>
      status == MyPathStatus.completed ? 1 : completedSteps / 4;

  int get currentStep {
    if (goal == null) return 0;
    if (level == null) return 1;
    if (skill == null) return 2;
    if (hours == null) return 3;
    return 4;
  }

  bool get hasPlan => goal != null || level != null || skill != null;

  MyPathState copyWith({
    MyPathOption? goal,
    MyPathOption? level,
    MyPathSkillOption? skill,
    MyPathOption? hours,
    RoadmapDto? roadmap,
    MyPathStatus? status,
    bool? roadmapLoading,
    Set<int>? enrolledCourseIds,
    bool clearGoal = false,
    bool clearLevel = false,
    bool clearSkill = false,
    bool clearHours = false,
    bool clearRoadmap = false,
  }) {
    return MyPathState(
      goal: clearGoal ? null : (goal ?? this.goal),
      level: clearLevel ? null : (level ?? this.level),
      skill: clearSkill ? null : (skill ?? this.skill),
      hours: clearHours ? null : (hours ?? this.hours),
      roadmap: clearRoadmap ? null : (roadmap ?? this.roadmap),
      status: status ?? this.status,
      roadmapLoading: roadmapLoading ?? this.roadmapLoading,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
    );
  }

  @override
  List<Object?> get props => [
        goal,
        level,
        skill,
        hours,
        roadmap,
        status,
        roadmapLoading,
        enrolledCourseIds,
      ];
}
