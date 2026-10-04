/// Shared display formatters.
library;

/// Formats a numeric [value] (string-encoded) as US dollars with 2 decimals.
///
/// Returns the original string when it cannot be parsed as a number.
String formatMoney(String value) {
  final amount = double.tryParse(value);
  if (amount == null) return value;
  return '\$${amount.toStringAsFixed(2)}';
}
