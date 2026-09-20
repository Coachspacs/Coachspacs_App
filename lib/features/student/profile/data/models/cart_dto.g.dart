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
  subtotal: json['subtotal'] as String,
  discount: json['discount'] as String,
  total: json['total'] as String,
  couponCode: json['coupon_code'] as String?,
);

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
  'id': instance.id,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'item_count': instance.itemCount,
  'subtotal': instance.subtotal,
  'discount': instance.discount,
  'total': instance.total,
  'coupon_code': instance.couponCode,
};

CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) => CartItemDto(
  id: (json['id'] as num).toInt(),
  course: CartItemCourseDto.fromJson(json['course'] as Map<String, dynamic>),
  price: json['price'] as String,
);

Map<String, dynamic> _$CartItemDtoToJson(CartItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course': instance.course.toJson(),
      'price': instance.price,
    };

CartItemCourseDto _$CartItemCourseDtoFromJson(Map<String, dynamic> json) =>
    CartItemCourseDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      coverImage: json['cover_image'] as String,
      instructor: CartInstructorDto.fromJson(
        json['instructor'] as Map<String, dynamic>,
      ),
      price: json['price'] as String,
      isFree: boolFromJson(json['is_free']),
    );

Map<String, dynamic> _$CartItemCourseDtoToJson(CartItemCourseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover_image': instance.coverImage,
      'instructor': instance.instructor.toJson(),
      'price': instance.price,
      'is_free': instance.isFree,
    };

CartInstructorDto _$CartInstructorDtoFromJson(Map<String, dynamic> json) =>
    CartInstructorDto(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
    );

Map<String, dynamic> _$CartInstructorDtoToJson(CartInstructorDto instance) =>
    <String, dynamic>{'id': instance.id, 'full_name': instance.fullName};

AddCartItemRequest _$AddCartItemRequestFromJson(Map<String, dynamic> json) =>
    AddCartItemRequest(courseId: (json['course_id'] as num).toInt());

Map<String, dynamic> _$AddCartItemRequestToJson(AddCartItemRequest instance) =>
    <String, dynamic>{'course_id': instance.courseId};
