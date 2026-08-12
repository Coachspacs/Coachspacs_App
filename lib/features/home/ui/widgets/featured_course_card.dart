import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_color_tokens.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/core/theming/app_shadows.dart';
import 'package:coach_space/features/home/data/models/course.dart';
import 'package:coach_space/features/home/ui/widgets/course_cover_image.dart';

/// Large vertical card used in the "Featured Courses" section.
class FeaturedCourseCard extends StatelessWidget {
  const FeaturedCourseCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final course = this.course;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        boxShadow: AppShadows.card,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Banner(course: course),
              Padding(
                padding: const EdgeInsets.all(AppDimens.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: AppDimens.stackGapSm),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            course.instructor.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.stackGapMd),
                    Row(
                      children: [
                        _RatingSummary(rating: course.rating, reviewCount: course.reviewCount),
                        const Spacer(),
                        Text(
                          course.formattedPrice,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: colorScheme.primaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final categoryLabel = course.categoryLabel;

    return SizedBox(
      height: AppDimens.featuredBannerHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CourseCoverImage(imageUrl: course.coverImageUrl),
          if (categoryLabel != null)
            PositionedDirectional(
              top: AppDimens.marginMobile,
              start: AppDimens.marginMobile,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.stackGapSm,
                  vertical: AppDimens.unit,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  boxShadow: AppShadows.interactive,
                ),
                child: Text(
                  categoryLabel,
                  style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSecondary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Star + numeric rating (+ review count) row.
class _RatingSummary extends StatelessWidget {
  const _RatingSummary({required this.rating, required this.reviewCount});

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        const Icon(Icons.star, size: 18, color: AppColorTokens.tertiaryFixedDim),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: theme.textTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount)',
          style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
        ),
      ],
    );
  }
}
