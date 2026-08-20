import 'package:json_annotation/json_annotation.dart';

/// Account role returned by the API.
///
/// The backend may add roles over time; unknown values parse to [unknown]
/// so the app never crashes on a new role.
enum UserRole {
  student,
  instructor,
  admin,
  unknown;

  static UserRole fromString(String? value) =>
      UserRole.values.asNameMap()[value] ?? UserRole.unknown;
}

/// Safe JSON codec for [UserRole].
class UserRoleConverter implements JsonConverter<UserRole, String> {
  const UserRoleConverter();

  @override
  UserRole fromJson(String json) => UserRole.fromString(json);

  @override
  String toJson(UserRole role) =>
      role == UserRole.unknown ? 'unknown' : role.name;
}
