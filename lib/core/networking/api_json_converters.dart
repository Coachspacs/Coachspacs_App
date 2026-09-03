/// Normalizes scalar values from serializer fields whose OpenAPI schema is
/// emitted as `string` even though their semantic value is a boolean or int.
///
/// The backend normally returns native JSON values. Supporting their string
/// representation as well prevents an otherwise valid response from failing
/// to deserialize when a serializer uses a computed field.
bool boolFromJson(Object? value) {
  return switch (value) {
    bool value => value,
    String value => value.toLowerCase() == 'true' || value == '1',
    num value => value != 0,
    _ => false,
  };
}

int intFromJson(Object? value) {
  return switch (value) {
    int value => value,
    num value => value.toInt(),
    String value => int.parse(value),
    _ => throw FormatException('Expected an integer, received: $value'),
  };
}
