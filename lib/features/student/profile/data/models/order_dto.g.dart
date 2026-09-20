// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
  id: (json['id'] as num).toInt(),
  orderNumber: json['order_number'] as String,
  status: OrderDto._statusFromJson(json['status']),
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  subtotal: json['subtotal'] as String,
  discount: json['discount'] as String,
  tax: json['tax'] as String,
  total: json['total'] as String,
  currency: json['currency'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  paymentMethod: json['payment_method'] as String?,
  paidAt: json['paid_at'] == null
      ? null
      : DateTime.parse(json['paid_at'] as String),
);

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'order_number': instance.orderNumber,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'subtotal': instance.subtotal,
  'discount': instance.discount,
  'tax': instance.tax,
  'total': instance.total,
  'currency': instance.currency,
  'payment_method': instance.paymentMethod,
  'created_at': instance.createdAt.toIso8601String(),
  'paid_at': instance.paidAt?.toIso8601String(),
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
  courseId: (json['course_id'] as num).toInt(),
  courseTitle: json['course_title'] as String,
  coverImage: json['cover_image'] as String,
  price: json['price'] as String,
);

Map<String, dynamic> _$OrderItemDtoToJson(OrderItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'course_title': instance.courseTitle,
      'cover_image': instance.coverImage,
      'price': instance.price,
    };

CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) =>
    CreateOrderRequest(couponCode: json['coupon_code'] as String?);

Map<String, dynamic> _$CreateOrderRequestToJson(CreateOrderRequest instance) =>
    <String, dynamic>{'coupon_code': ?instance.couponCode};
