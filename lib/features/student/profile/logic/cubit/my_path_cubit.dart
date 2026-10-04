import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../student/my_learning/data/repo/enrollment_repository.dart';
import '../../data/models/my_path_models.dart';
import '../../data/models/roadmap_dtos.dart';
import '../../data/repo/roadmap_repository.dart';
import 'my_path_state.dart';

export 'my_path_state.dart';

/// Wizard selections → `POST /api/ai/roadmap/generate` payload mapping:
/// - Goal  → `goal_text` (the option title; `category` stays null because the
///   spec leaves it optional and does not enumerate valid values).
/// - Level → `current_level` (`beginner`/`basic`/`intermediate`/`advanced`).
/// - Hours → `weekly_hours` (`1-2`/`3-5`/`6-10`/`10+`).
/// The Skill step has no API field, so it is kept UI-only.
class MyPathCubit extends Cubit<MyPathState> {
  MyPathCubit({required RoadmapRepository repository, EnrollmentRepository? enrollmentRepository})
    : _repository = repository,
      _enrollmentRepository = enrollmentRepository,
      super(const MyPathState());

  final RoadmapRepository _repository;
  final EnrollmentRepository? _enrollmentRepository;

  /// Best-effort fetch of page 1 of the student's enrollments so the roadmap
  /// screen can show "Start Learning" instead of "Enroll & Purchase".
  Future<void> _loadEnrollments() async {
    final enrollmentRepository = _enrollmentRepository;
    if (enrollmentRepository == null) return;
    try {
      final page = await enrollmentRepository.getEnrollments(
        page: 1,
        pageSize: 100,
      );
      final ids = <int>{
        for (final e in page.results) e.course.id,
      };
      if (ids.isNotEmpty) {
        emit(state.copyWith(enrolledCourseIds: ids));
      }
    } catch (_) {
      // Enrollment knowledge is a nicety, never a blocker.
    }
  }

  /// Pulls the active path (if any) so returning students see the roadmap
  /// instead of the wizard. Best effort: option cards only light up when the
  /// server values match a known wizard option.
  Future<void> load() async {
    if (state.roadmap != null) return;
    emit(state.copyWith(roadmapLoading: true));
    final RoadmapDto? path;
    try {
      path = await _repository.getRoadmap();
    } catch (_) {
      emit(state.copyWith(roadmapLoading: false));
      return; // Offline-friendly: the local plan keeps working.
    }
    if (path == null) {
      emit(state.copyWith(roadmapLoading: false));
      await _loadEnrollments();
      return;
    }
    emit(
      _stateFromRoadmap(path).copyWith(
        roadmap: path,
        roadmapLoading: false,
      ),
    );
    await _loadEnrollments();
  }

  /// Forces a fresh fetch of the active path — used when returning from
  /// enrolling/purchasing a milestone course. The server is the source of
  /// truth for milestones, statuses and ordering.
  Future<void> refreshRoadmap() async {
    final RoadmapDto? path;
    try {
      path = await _repository.getRoadmap();
    } catch (_) {
      return;
    }
    if (path == null) return;
    emit(
      _stateFromRoadmap(path).copyWith(
        roadmap: path,
        roadmapLoading: false,
      ),
    );
    await _loadEnrollments();
  }

  /// Marks/undoes a milestone as completed. Optimistic locally; the server
  /// is patched with `completed`/`pending` right after.
  Future<void> toggleStepCompletion(int stepId) async {
    final steps = state.roadmap?.steps ?? const <RoadmapStepDto>[];
    if (steps.isEmpty) return;
    RoadmapStepDto? target;
    final updated = [
      for (final step in steps)
        if (step.id == stepId)
          (target = step).copyWith(
            status: step.isCompleted ? 'pending' : 'completed',
          )
        else
          step,
    ];
    final wasCompleted = target?.isCompleted ?? false;
    _emitRoadmapSteps(updated);
    await _patchStep(stepId, status: wasCompleted ? 'pending' : 'completed');
  }

  /// Skips / restores a milestone (`skipped` ↔ `pending`).
  Future<void> toggleStepSkip(int stepId) async {
    final steps = state.roadmap?.steps ?? const <RoadmapStepDto>[];
    if (steps.isEmpty) return;
    bool skipping = false;
    final updated = [
      for (final step in steps)
        if (step.id == stepId) ...[
          () {
            skipping = !step.isSkipped;
            return step.copyWith(
              status: skipping ? 'skipped' : 'pending',
            );
          }(),
        ] else
          step,
    ];
    _emitRoadmapSteps(updated);
    await _patchStep(stepId, status: skipping ? 'skipped' : 'pending');
    // The server may recompute step metadata (e.g. unlock order) after a
    // skip; mirror the web client and refresh.
    await refreshRoadmap();
  }

  /// Swaps a step with its neighbour and patches **only the moved step**
  /// with its new 1-based order — mirroring the web client behaviour.
  Future<void> moveStep(
    int indexInRail, {
    required bool up,
  }) async {
    if (state.roadmap == null) return;
    final ordered = state.roadmap!.orderedSteps;
    if (ordered.isEmpty) return;
    final target = up ? indexInRail - 1 : indexInRail + 1;
    if (indexInRail < 0 || indexInRail >= ordered.length) return;
    if (target < 0 || target >= ordered.length) return;

    final reordered = [...ordered];
    final moved = reordered[indexInRail];
    reordered[indexInRail] = reordered[target];
    reordered[target] = moved;

    final renumbered = [
      for (var i = 0; i < reordered.length; i++)
        reordered[i].copyWith(order: i + 1),
    ];

    _emitRoadmapSteps(renumbered);
    await _patchStep(moved.id, order: target + 1);
  }

  void _emitRoadmapSteps(List<RoadmapStepDto> steps) {
    final roadmap = state.roadmap;
    if (roadmap == null) return;
    emit(state.copyWith(roadmap: roadmap.copyWith(steps: steps)));
  }

  Future<void> _patchStep(
    int stepId, {
    String? status,
    int? order,
  }) async {
    try {
      await _repository.updateStep(
        stepId,
        RoadmapStepUpdateRequest(status: status, order: order),
      );
    } catch (_) {
      // Optimistic update failed server-side — pull the source of truth.
      await refreshRoadmap();
    }
  }

  MyPathState _stateFromRoadmap(RoadmapDto path) {
    String norm(String? value) => value?.trim().toLowerCase() ?? '';

    MyPathOption? matchOption(List<MyPathOption> options, String? value) {
      final query = norm(value);
      if (query.isEmpty) return null;
      for (final option in options) {
        if (norm(option.title).contains(query) ||
            query.contains(norm(option.title))) {
          return option;
        }
      }
      return null;
    }

    MyPathOption? matchLevel(String? value) {
      final query = norm(value);
      const levels = MyPathLevelOptionsData.all;
      const keys = ['beginner', 'basic', 'intermediate', 'advanced'];
      for (var i = 0; i < keys.length; i++) {
        if (query.contains(keys[i])) return levels[i];
      }
      return matchOption(levels, value);
    }

    MyPathOption _hoursOption(int id) {
      final titles = ['1-2', '3-5', '6-10', '10+'];
      return MyPathOption(
        id: id,
        icon: Icons.schedule_outlined,
        title: titles[id],
        description: titles[id],
      );
    }

    MyPathOption? matchHours(String? value) {
      final query = norm(value).replaceAll(RegExp(r'\s'), '');
      const keys = ['1-2', '3-5', '6-10', '10+'];
      for (var i = 0; i < keys.length; i++) {
        if (query.contains(keys[i])) return _hoursOption(i);
      }
      return null;
    }

    final goal = matchOption(MyPathGoalOptionsData.all, path.goalText ?? path.category);
    final level = matchLevel(path.currentLevel);
    final skill = _matchSkill(path.category);
    final hours = matchHours(path.weeklyHours);

    var status = MyPathStatus.inProgress;
    if (goal != null && level != null && skill != null && hours != null) {
      status = MyPathStatus.completed;
    } else if (path.steps.isEmpty) {
      status = MyPathStatus.inProgress;
    }
    if (norm(path.status).contains('complete')) {
      status = MyPathStatus.completed;
    }

    return MyPathState(
      goal: goal,
      level: level,
      skill: skill,
      hours: hours,
      roadmap: path,
      status: status,
    );
  }

  MyPathSkillOption? _matchSkill(String? value) {
    final query = value?.trim().toLowerCase() ?? '';
    if (query.isEmpty) return null;
    for (final skill in MyPathSkillOptionsData.all) {
      if (skill.title.toLowerCase().contains(query) ||
          query.contains(skill.title.toLowerCase())) {
        return skill;
      }
      for (final tag in skill.tags) {
        if (query.contains(tag.toLowerCase())) return skill;
      }
    }
    return null;
  }

  void selectGoal(MyPathOption goal) {
    emit(state.copyWith(goal: goal, status: MyPathStatus.inProgress));
  }

  void selectLevel(MyPathOption level) {
    emit(state.copyWith(level: level));
  }

  void selectSkill(MyPathSkillOption skill) {
    emit(state.copyWith(skill: skill));
  }

  void selectHours(MyPathOption hours) {
    emit(state.copyWith(hours: hours));
  }

  /// Called from the last wizard step. Marks the plan complete locally right
  /// away, then syncs the server in the background: first run generates a
  /// path, re-running the wizard regenerates around the changed inputs.
  Future<void> complete() async {
    emit(state.copyWith(status: MyPathStatus.completed, roadmapLoading: true));
    final existing = state.roadmap;
    try {
      final dto = existing == null
          ? await _repository.generateRoadmap(
              RoadmapGenerateRequest(
                goalText: state.goal?.title,
                currentLevel: _levelKey(state.level),
                weeklyHours: _hoursKey(state.hours),
              ),
            )
          : await _repository.regenerateRoadmap(
              RoadmapRegenerateRequest(
                goalText: state.goal?.title,
                currentLevel: _levelKey(state.level),
                weeklyHours: _hoursKey(state.hours),
              ),
            );
      emit(
        state.copyWith(
          roadmap: dto,
          roadmapLoading: false,
        ),
      );
    } catch (_) {
      // The local plan stays valid; the server copy is refreshed by load().
      emit(state.copyWith(roadmapLoading: false));
    }
  }

  /// Skips/starts a roadmap step (server vocabulary: `skipped`/`pending`).
  /// Kept for older call sites — the roadmap screen uses [toggleStepSkip]
  /// and [toggleStepCompletion] which stay optimistic.
  Future<void> updateStepStatus(int stepId, String status) async {
    try {
      await _repository.updateStep(stepId, RoadmapStepUpdateRequest(status: status));
    } catch (_) {
      return;
    }
    _emitRoadmapSteps([
      for (final step in state.roadmap?.steps ?? const <RoadmapStepDto>[])
        if (step.id == stepId) step.copyWith(status: status) else step,
    ]);
  }

  /// Restarts the wizard while keeping the server path so finishing the
  /// wizard again regenerates instead of duplicating paths.
  void restart() {
    emit(state.copyWith(
      status: MyPathStatus.notStarted,
      clearGoal: true,
      clearLevel: true,
      clearSkill: true,
      clearHours: true,
    ));
  }

  String _levelKey(MyPathOption? level) =>
      switch (level?.id) { 0 => 'beginner', 1 => 'basic', 2 => 'intermediate', 3 => 'advanced', _ => 'beginner' };

  String _hoursKey(MyPathOption? hours) =>
      switch (hours?.id) { 0 => '1-2', 1 => '3-5', 2 => '6-10', 3 => '10+', _ => '3-5' };
}
