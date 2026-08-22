import 'dart:io';

import 'package:coach_space/features/profile/data/models/confirm_email_change_request.dart';
import 'package:coach_space/features/profile/data/models/user_profile_model.dart';

/// Contract for `GET/PUT /api/users/me` and related account endpoints.
abstract interface class ProfileRepository {
  Future<UserProfileModel> getProfile();

  Future<UserProfileModel> updateProfile({required String fullName});

  Future<UserProfileModel> uploadAvatar(File file);

  Future<void> requestEmailChange({required String newEmail});

  Future<void> confirmEmailChange(ConfirmEmailChangeRequest request);
}
