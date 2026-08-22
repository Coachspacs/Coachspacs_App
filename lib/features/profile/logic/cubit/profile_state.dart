import 'package:equatable/equatable.dart';

import 'package:coach_space/features/profile/data/models/user_profile_model.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => const [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoadSuccess extends ProfileState {
  const ProfileLoadSuccess(this.profile);

  final UserProfileModel profile;

  @override
  List<Object?> get props => [profile];
}

class ProfileLoadFailure extends ProfileState {
  const ProfileLoadFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ProfileSaving extends ProfileState {
  const ProfileSaving();
}

class ProfileSaveSuccess extends ProfileState {
  const ProfileSaveSuccess(this.profile);

  final UserProfileModel profile;

  @override
  List<Object?> get props => [profile];
}

class ProfileSaveFailure extends ProfileState {
  const ProfileSaveFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ProfileAvatarUploading extends ProfileState {
  const ProfileAvatarUploading();
}

class ProfileAvatarSuccess extends ProfileState {
  const ProfileAvatarSuccess(this.profile);

  final UserProfileModel profile;

  @override
  List<Object?> get props => [profile];
}

class ProfileAvatarFailure extends ProfileState {
  const ProfileAvatarFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ProfileEmailChangeLoading extends ProfileState {
  const ProfileEmailChangeLoading();
}

class ProfileEmailChangeSuccess extends ProfileState {
  const ProfileEmailChangeSuccess();
}

class ProfileEmailChangeFailure extends ProfileState {
  const ProfileEmailChangeFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ProfileEmailConfirmLoading extends ProfileState {
  const ProfileEmailConfirmLoading();
}

class ProfileEmailConfirmSuccess extends ProfileState {
  const ProfileEmailConfirmSuccess();
}

class ProfileEmailConfirmFailure extends ProfileState {
  const ProfileEmailConfirmFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
