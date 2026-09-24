// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
  id: (json['id'] as num).toInt(),
  status: OrderDto._statusFromJson(json['status']),
  totalAmount: json['total_amount'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'total_amount': instance.totalAmount,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'created_at': instance.createdAt.toIso8601String(),
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.paid: 'paid',
  OrderStatus.failed: 'failed',
  OrderStatus.refunded: 'refunded',
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.unknown: 'unknown',
};

OrderItemDto _$OrderItemDtoFromJson(Map<String, dynamic> json) => OrderItemDto(
  id: (json['id'] as num).toInt(),
  course: OrderItemCourseDto.fromJson(json['course'] as Map<String, dynamic>),
  priceAtPurchase: json['price_at_purchase'] as String,
);

Map<String, dynamic> _$OrderItemDtoToJson(OrderItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course': instance.course.toJson(),
      'price_at_purchase': instance.priceAtPurchase,
    };

OrderItemCourseDto _$OrderItemCourseDtoFromJson(Map<String, dynamic> json) =>
    OrderItemCourseDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: json['price'] as String,
      coverImage: json['cover_image'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$OrderItemCourseDtoToJson(OrderItemCourseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'cover_image': instance.coverImage,
      'status': instance.status,
    };
