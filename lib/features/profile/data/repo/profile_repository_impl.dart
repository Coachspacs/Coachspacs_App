import 'dart:io';

import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/profile/data/models/change_email_request.dart';
import 'package:coach_space/features/profile/data/models/confirm_email_change_request.dart';
import 'package:coach_space/features/profile/data/models/update_profile_request.dart';
import 'package:coach_space/features/profile/data/models/user_profile_model.dart';
import 'package:coach_space/features/profile/data/repo/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<UserProfileModel> getProfile() =>
      _guard(() => _api.getMe());

  @override
  Future<UserProfileModel> updateProfile({required String fullName}) =>
      _guard(() => _api.updateMe(UpdateProfileRequest(fullName: fullName)));

  @override
  Future<UserProfileModel> uploadAvatar(File file) =>
      _guard(() => _api.uploadAvatar(file));

  @override
  Future<void> requestEmailChange({required String newEmail}) =>
      _guard(() => _api.requestEmailChange(ChangeEmailRequest(newEmail: newEmail)));

  @override
  Future<void> confirmEmailChange(ConfirmEmailChangeRequest request) =>
      _guard(() => _api.confirmEmailChange(request));

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
