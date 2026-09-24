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

/// `GET /api/orders` response body.
@JsonSerializable(explicitToJson: true)
class OrderDto {
  const OrderDto({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.items,
    required this.createdAt,
  });

  final int id;
  @JsonKey(fromJson: _statusFromJson)
  final OrderStatus status;
  @JsonKey(name: 'total_amount')
  final String totalAmount;
  final List<OrderItemDto> items;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  static OrderStatus _statusFromJson(Object? value) =>
      OrderStatus.fromJson(value?.toString());

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderItemDto {
  const OrderItemDto({
    required this.id,
    required this.course,
    required this.priceAtPurchase,
  });

  final int id;
  final OrderItemCourseDto course;
  @JsonKey(name: 'price_at_purchase')
  final String priceAtPurchase;

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);
}

@JsonSerializable()
class OrderItemCourseDto {
  const OrderItemCourseDto({
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

  factory OrderItemCourseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemCourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemCourseDtoToJson(this);
}
