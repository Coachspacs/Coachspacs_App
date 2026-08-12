import 'package:flutter/material.dart';

/// Soft, low-opacity elevation shadows for the Coach Space design system.
///
/// Modern surfaces use subtle ambient elevation instead of harsh drop
/// shadows. Consume these tokens (never raw `BoxShadow`s in feature code)
/// so elevation stays consistent and subtle app-wide.
abstract final class AppShadows {
  AppShadows._();

  /// Default card / container elevation — very subtle (≈4% black, 12px blur).
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Floating control (search field, nav bar) elevation.
  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  /// Bottom nav bar — upward cast shadow.
  static const List<BoxShadow> nav = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 16,
      offset: Offset(0, -4),
    ),
  ];

  /// Interactive state (selected chip) elevation.
  static const List<BoxShadow> interactive = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];
}
