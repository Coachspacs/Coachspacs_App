import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/roadmap_dtos.dart';

import 'roadmap_repository.dart';

class RoadmapRepositoryImpl implements RoadmapRepository {
  RoadmapRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<RoadmapDto?> getRoadmap() async =>
      (await _guard(() => _api.getRoadmap())).path;

  @override
  Future<RoadmapDto?> generateRoadmap(RoadmapGenerateRequest body) async =>
      (await _guard(() => _api.generateRoadmap(body))).path;

  @override
  Future<RoadmapDto?> regenerateRoadmap(RoadmapRegenerateRequest body) async =>
      (await _guard(() => _api.regenerateRoadmap(body))).path;

  @override
  Future<void> updateStep(int stepId, RoadmapStepUpdateRequest body) =>
      _guard(() => _api.updateRoadmapStep(stepId, body));

  Future<T> _guard<T>(Future<T> Function() request) =>
      NetworkException.guard(request);
}
