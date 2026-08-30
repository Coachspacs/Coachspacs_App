import 'package:equatable/equatable.dart';

/// Profile summary for the signed-in user shown on the home screen.
class UserProfile extends Equatable {
  const UserProfile({required this.id, required this.name, this.avatarUrl});

  final String id;
  final String name;
  final String? avatarUrl;

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
