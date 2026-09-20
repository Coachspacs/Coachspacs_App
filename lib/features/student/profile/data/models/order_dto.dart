import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

/// Order lifecycle status as returned by the backend.
enum OrderStatus {
  pending,
  paid,
  failed,
  refunded,
  cancelled,
  unknown;

  static OrderStatus fromJson(String? value) {
    return switch (value) {
      'pending' => OrderStatus.pending,
      'paid' => OrderStatus.paid,
      'failed' => OrderStatus.failed,
      'refunded' => OrderStatus.refunded,
      'cancelled' => OrderStatus.cancelled,
      _ => OrderStatus.unknown,
    };
  }
}

/// `GET /api/orders` / `POST /api/orders` response body.
@JsonSerializable(explicitToJson: true)
class OrderDto {
  const OrderDto({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.total,
    required this.currency,
    required this.createdAt,
    this.paymentMethod,
    this.paidAt,
  });

  final int id;
  @JsonKey(name: 'order_number')
  final String orderNumber;
  @JsonKey(fromJson: _statusFromJson)
  final OrderStatus status;
  final List<OrderItemDto> items;
  final String subtotal;
  final String discount;
  final String tax;
  final String total;
  final String currency;
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'paid_at')
  final DateTime? paidAt;

  static OrderStatus _statusFromJson(Object? value) =>
      OrderStatus.fromJson(value?.toString());

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}

@JsonSerializable()
class OrderItemDto {
  const OrderItemDto({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.coverImage,
    required this.price,
  });

  final int id;
  @JsonKey(name: 'course_id')
  final int courseId;
  @JsonKey(name: 'course_title')
  final String courseTitle;
  @JsonKey(name: 'cover_image')
  final String coverImage;
  final String price;

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);
}

/// `POST /api/orders` request body.
///
/// `includeIfNull: false` omits `coupon_code` entirely when no coupon is
/// applied instead of sending an explicit `null`.
@JsonSerializable(includeIfNull: false)
class CreateOrderRequest {
  const CreateOrderRequest({this.couponCode});

  @JsonKey(name: 'coupon_code')
  final String? couponCode;

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);
}
