import 'package:coach_space/features/student/profile/data/models/roadmap_dtos.dart';

abstract class RoadmapRepository {
  /// The student's active path, or null when none exists yet.
  Future<RoadmapDto?> getRoadmap();

  /// Builds a fresh path; only valid while the student has none.
  Future<RoadmapDto?> generateRoadmap(RoadmapGenerateRequest body);

  /// Rebuilds around changed inputs; the old path is archived server-side.
  Future<RoadmapDto?> regenerateRoadmap(RoadmapRegenerateRequest body);

  /// Skip/restore/reorder one step of the active path.
  Future<void> updateStep(int stepId, RoadmapStepUpdateRequest body);
}
