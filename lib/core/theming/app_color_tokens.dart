import 'package:flutter/material.dart';

/// Material 3 color tokens mapped from the Coach Space design system palette.
///
/// These tokens mirror the canonical Tailwind/HTML mockup palette and feed
/// [AppTheme]'s [ColorScheme]. Do not hardcode raw hex values in feature code;
/// consume them via `Theme.of(context).colorScheme`.
abstract final class AppColorTokens {
  // Surface / background.
  static const Color surface = Color(0xFFF8F9FA);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF3F4F5);
  static const Color surfaceContainer = Color(0xFFEDEEEF);
  static const Color surfaceContainerHigh = Color(0xFFE7E8E9);
  static const Color surfaceContainerHighest = Color(0xFFE1E3E4);
  static const Color surfaceDim = Color(0xFFD9DADB);

  static const Color onSurface = Color(0xFF191C1D);
  static const Color onSurfaceVariant = Color(0xFF454652);
  static const Color outline = Color(0xFF767683);
  static const Color outlineVariant = Color(0xFFC6C5D4);

  // Primary (brand indigo).
  static const Color primary = Color(0xFF000666);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF1A237E);
  static const Color onPrimaryContainer = Color(0xFF8690EE);
  static const Color primaryFixedDim = Color(0xFFBDC2FF);
  static const Color surfaceTint = Color(0xFF4C56AF);

  // Secondary (success green).
  static const Color secondary = Color(0xFF006E1C);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF91F78E);
  static const Color onSecondaryContainer = Color(0xFF00731E);

  // Tertiary / rating accent.
  static const Color tertiary = Color(0xFF251900);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF3F2D00);
  static const Color onTertiaryContainer = Color(0xFFC09000);
  static const Color tertiaryFixedDim = Color(0xFFFABD00);

  // Error.
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);
}
