import 'package:json_annotation/json_annotation.dart';

import 'package:coach_space/core/networking/api_json_converters.dart';

part 'cart_dto.g.dart';

/// `GET /api/cart` response body.
@JsonSerializable(explicitToJson: true)
class CartDto {
  const CartDto({
    required this.id,
    required this.items,
    required this.itemCount,
    required this.total,
    required this.createdAt,
  });

  final int id;
  final List<CartItemDto> items;
  @JsonKey(name: 'item_count', fromJson: intFromJson)
  final int itemCount;
  final String total;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  bool get isEmpty => items.isEmpty;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartItemDto {
  const CartItemDto({
    required this.id,
    required this.course,
    required this.isAvailable,
    required this.addedAt,
  });

  final int id;
  final CartItemCourseDto course;
  @JsonKey(name: 'is_available', fromJson: boolFromJson)
  final bool isAvailable;
  @JsonKey(name: 'added_at')
  final DateTime addedAt;

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartItemCourseDto {
  const CartItemCourseDto({
    required this.id,
    required this.title,
    required this.price,
    this.coverImage = '',
    this.status = '',
  });

  final int id;
  final String title;
  final String price;
  @JsonKey(name: 'cover_image', defaultValue: '')
  final String coverImage;
  @JsonKey(defaultValue: '')
  final String status;

  factory CartItemCourseDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemCourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemCourseDtoToJson(this);
}

/// `POST /api/cart/items` request body.
@JsonSerializable()
class AddCartItemRequest {
  const AddCartItemRequest({required this.courseId});

  @JsonKey(name: 'course_id')
  final int courseId;

  factory AddCartItemRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCartItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddCartItemRequestToJson(this);
}
