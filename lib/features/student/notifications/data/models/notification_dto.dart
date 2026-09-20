import 'package:json_annotation/json_annotation.dart';

import 'package:coach_space/core/networking/api_json_converters.dart';

part 'notification_dto.g.dart';

/// `GET /api/notifications` item.
@JsonSerializable()
class NotificationDto {
  const NotificationDto({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String message;
  final String type;
  @JsonKey(name: 'is_read', fromJson: boolFromJson)
  final bool isRead;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  NotificationDto copyWith({bool? isRead}) => NotificationDto(
    id: id,
    title: title,
    message: message,
    type: type,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt,
  );

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);
}
