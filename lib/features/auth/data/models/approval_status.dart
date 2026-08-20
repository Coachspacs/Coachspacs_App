import 'package:json_annotation/json_annotation.dart';

/// Instructor approval state returned by the API.
///
/// Unknown backend values parse to [unknown] — the UI routes safely on the
/// known values (approved/pending/rejected) and never crashes otherwise.
enum ApprovalStatus {
  approved,
  pending,
  rejected,
  unknown;

  static ApprovalStatus fromString(String? value) =>
      ApprovalStatus.values.asNameMap()[value] ?? ApprovalStatus.unknown;
}

/// Safe JSON codec for [ApprovalStatus].
class ApprovalStatusConverter implements JsonConverter<ApprovalStatus, String> {
  const ApprovalStatusConverter();

  @override
  ApprovalStatus fromJson(String json) => ApprovalStatus.fromString(json);

  @override
  String toJson(ApprovalStatus status) =>
      status == ApprovalStatus.unknown ? 'unknown' : status.name;
}
