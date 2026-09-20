import 'dart:io';

import 'package:coach_space/features/student/profile/logic/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';

import '../../data/models/confirm_email_change_request.dart';
import '../../data/repo/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required ProfileRepository repository})
      : _repo = repository,
        super(const ProfileInitial());

  final ProfileRepository _repo;

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    try {
      final profile = await _repo.getProfile();
      emit(ProfileLoadSuccess(profile));
    } on NetworkException catch (error) {
      emit(ProfileLoadFailure(error.message, kind: error.kind));
    } catch (error) {
      emit(ProfileLoadFailure(_messageOf(error)));
    }
  }

  Future<void> saveProfile({required String fullName}) async {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) {
      emit(const ProfileSaveFailure('الاسم الكامل مطلوب'));
      return;
    }
    emit(const ProfileSaving());
    try {
      final updated = await _repo.updateProfile(fullName: trimmed);
      emit(ProfileSaveSuccess(updated));
    } catch (error) {
      emit(ProfileSaveFailure(_messageOf(error)));
    }
  }

  Future<void> uploadAvatar(File file) async {
    emit(const ProfileAvatarUploading());
    try {
      final updated = await _repo.uploadAvatar(file);
      emit(ProfileAvatarSuccess(updated));
    } catch (error) {
      emit(ProfileAvatarFailure(_messageOf(error)));
    }
  }

  Future<void> requestEmailChange(String newEmail) async {
    final trimmed = newEmail.trim();
    if (trimmed.isEmpty) {
      emit(const ProfileEmailChangeFailure('البريد الإلكتروني مطلوب'));
      return;
    }
    emit(const ProfileEmailChangeLoading());
    try {
      await _repo.requestEmailChange(newEmail: trimmed);
      emit(const ProfileEmailChangeSuccess());
    } catch (error) {
      emit(ProfileEmailChangeFailure(_messageOf(error)));
    }
  }

  Future<void> confirmEmailChange({
    required String uid,
    required String token,
  }) async {
    emit(const ProfileEmailConfirmLoading());
    try {
      await _repo.confirmEmailChange(
        ConfirmEmailChangeRequest(uid: uid, token: token),
      );
      emit(const ProfileEmailConfirmSuccess());
    } catch (error) {
      emit(ProfileEmailConfirmFailure(_messageOf(error)));
    }
  }

  String _messageOf(Object error) {
    if (error is NetworkException) return error.message;
    return 'حدث خطأ، حاول مرة أخرى';
  }
}
