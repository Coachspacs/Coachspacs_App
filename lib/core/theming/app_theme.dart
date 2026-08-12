import 'package:flutter/material.dart';

import 'app_color_tokens.dart';

/// Central Material 3 theme definition for Coach Space.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColorTokens.surface,
      textTheme: _lightTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorTokens.surface,
        foregroundColor: AppColorTokens.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColorTokens.primary,
    onPrimary: AppColorTokens.onPrimary,
    primaryContainer: AppColorTokens.primaryContainer,
    onPrimaryContainer: AppColorTokens.onPrimaryContainer,
    secondary: AppColorTokens.secondary,
    onSecondary: AppColorTokens.onSecondary,
    secondaryContainer: AppColorTokens.secondaryContainer,
    onSecondaryContainer: AppColorTokens.onSecondaryContainer,
    tertiary: AppColorTokens.tertiary,
    onTertiary: AppColorTokens.onTertiary,
    tertiaryContainer: AppColorTokens.tertiaryContainer,
    onTertiaryContainer: AppColorTokens.onTertiaryContainer,
    error: AppColorTokens.error,
    onError: AppColorTokens.onError,
    errorContainer: AppColorTokens.errorContainer,
    onErrorContainer: AppColorTokens.onErrorContainer,
    surface: AppColorTokens.surface,
    onSurface: AppColorTokens.onSurface,
    onSurfaceVariant: AppColorTokens.onSurfaceVariant,
    outline: AppColorTokens.outline,
    outlineVariant: AppColorTokens.outlineVariant,
    surfaceContainerLowest: AppColorTokens.surfaceContainerLowest,
    surfaceContainerLow: AppColorTokens.surfaceContainerLow,
    surfaceContainer: AppColorTokens.surfaceContainer,
    surfaceContainerHigh: AppColorTokens.surfaceContainerHigh,
    surfaceContainerHighest: AppColorTokens.surfaceContainerHighest,
    surfaceTint: AppColorTokens.surfaceTint,
    shadow: Colors.black,
    scrim: Colors.black,
  );

  /// Typography scale mapped from the design system:
  /// display-lg → displaySmall, headline-md → headlineMedium,
  /// headline-sm → headlineSmall, body-lg → bodyLarge,
  /// body-md → bodyMedium, label-lg → labelLarge, label-sm → labelSmall.
  static const TextTheme _lightTextTheme = TextTheme(
    displaySmall: TextStyle(
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 18 / 14,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w500,
    ),
  );
}
