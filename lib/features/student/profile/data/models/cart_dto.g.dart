// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
  id: (json['id'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  itemCount: intFromJson(json['item_count']),
  total: json['total'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
  'id': instance.id,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'item_count': instance.itemCount,
  'total': instance.total,
  'created_at': instance.createdAt.toIso8601String(),
};

CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) => CartItemDto(
  id: (json['id'] as num).toInt(),
  course: CartItemCourseDto.fromJson(json['course'] as Map<String, dynamic>),
  isAvailable: boolFromJson(json['is_available']),
  addedAt: DateTime.parse(json['added_at'] as String),
);

Map<String, dynamic> _$CartItemDtoToJson(CartItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course': instance.course.toJson(),
      'is_available': instance.isAvailable,
      'added_at': instance.addedAt.toIso8601String(),
    };

CartItemCourseDto _$CartItemCourseDtoFromJson(Map<String, dynamic> json) =>
    CartItemCourseDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: json['price'] as String,
      coverImage: json['cover_image'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$CartItemCourseDtoToJson(CartItemCourseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'cover_image': instance.coverImage,
      'status': instance.status,
    };

AddCartItemRequest _$AddCartItemRequestFromJson(Map<String, dynamic> json) =>
    AddCartItemRequest(courseId: (json['course_id'] as num).toInt());

Map<String, dynamic> _$AddCartItemRequestToJson(AddCartItemRequest instance) =>
    <String, dynamic>{'course_id': instance.courseId};
