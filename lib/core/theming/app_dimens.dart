/// Spacing and sizing tokens from the Coach Space design system.
///
/// Use these constants instead of raw magic numbers to keep spacing
/// consistent across all features.
abstract final class AppDimens {
  AppDimens._();

  static const double unit = 4;
  static const double stackGapSm = 8;
  static const double gutterMobile = 12;
  static const double stackGapMd = 16;
  static const double cardPadding = 16;
  static const double marginMobile = 16;
  static const double stackGapLg = 24;

  static const double appBarLeadingSize = 40;
  static const double featuredBannerHeight = 192;
  static const double trendingThumbnailSize = 96;
  static const double chipHeight = 36;

  // Radius tokens (softer, modern corners).
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
}
