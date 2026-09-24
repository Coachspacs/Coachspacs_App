/// `POST /api/orders/checkout` response body (US-15 scenarios 1, 4, 5).
///
/// The response is not pinned down by the OpenAPI document, so parsing is
/// lenient: the order id and hosted checkout URL are looked up under several
/// candidate keys and optional fields are kept as-is.
class CheckoutSessionDto {
  const CheckoutSessionDto({
    required this.orderId,
    required this.checkoutUrl,
    this.skippedItems = const [],
    this.status,
  });

  final int orderId;
  final String checkoutUrl;

  /// Cart items excluded from this order because they were no longer
  /// purchasable (archived or already owned). Each entry is an opaque map.
  final List<Map<String, dynamic>> skippedItems;
  final String? status;

  factory CheckoutSessionDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    final rawOrder = first(const ['order_id', 'orderId', 'id']);
    final orderId = switch (rawOrder) {
      int value => value,
      num value => value.toInt(),
      String value => int.tryParse(value),
      _ => null,
    };

    final url = first(const [
      'checkout_url',
      'checkoutUrl',
      'url',
      'session_url',
      'redirect_url',
    ])?.toString();

    final skipped = first(const ['skipped_items', 'skipped']);
    final skippedItems = skipped is List
        ? skipped
              .whereType<Map<String, dynamic>>()
              .toList()
        : const <Map<String, dynamic>>[];

    return CheckoutSessionDto(
      orderId: orderId ?? 0,
      checkoutUrl: url ?? '',
      skippedItems: skippedItems,
      status: first(const ['status', 'session_status'])?.toString(),
    );
  }

  bool get hasCheckoutUrl => checkoutUrl.isNotEmpty;

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'checkout_url': checkoutUrl,
        if (status != null) 'status': status,
      };
}
