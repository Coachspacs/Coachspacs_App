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
    required this.subtotal,
    required this.discount,
    required this.total,
    this.couponCode,
  });

  final int id;
  final List<CartItemDto> items;
  @JsonKey(name: 'item_count', fromJson: intFromJson)
  final int itemCount;
  final String subtotal;
  final String discount;
  final String total;
  @JsonKey(name: 'coupon_code')
  final String? couponCode;

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
    required this.price,
  });

  final int id;
  final CartItemCourseDto course;
  final String price;

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartItemCourseDto {
  const CartItemCourseDto({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.instructor,
    required this.price,
    required this.isFree,
  });

  final int id;
  final String title;
  @JsonKey(name: 'cover_image')
  final String coverImage;
  final CartInstructorDto instructor;
  final String price;
  @JsonKey(name: 'is_free', fromJson: boolFromJson)
  final bool isFree;

  factory CartItemCourseDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemCourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemCourseDtoToJson(this);
}

@JsonSerializable()
class CartInstructorDto {
  const CartInstructorDto({
    required this.id,
    required this.fullName,
  });

  final int id;
  @JsonKey(name: 'full_name')
  final String fullName;

  factory CartInstructorDto.fromJson(Map<String, dynamic> json) =>
      _$CartInstructorDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartInstructorDtoToJson(this);
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
