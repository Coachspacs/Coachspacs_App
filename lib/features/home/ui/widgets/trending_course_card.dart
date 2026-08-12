import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_color_tokens.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/core/theming/app_shadows.dart';
import 'package:coach_space/features/home/data/models/course.dart';
import 'package:coach_space/features/home/ui/widgets/course_cover_image.dart';

/// Compact horizontal card used in the "Trending Now" section.
class TrendingCourseCard extends StatelessWidget {
  const TrendingCourseCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final course = this.course;
    final categoryLabel = course.categoryLabel;

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
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.stackGapSm),
            child: Row(
              children: [
                SizedBox(
                  width: AppDimens.trendingThumbnailSize,
                  height: AppDimens.trendingThumbnailSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    child: CourseCoverImage(imageUrl: course.coverImageUrl),
                  ),
                ),
                const SizedBox(width: AppDimens.gutterMobile),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (categoryLabel != null)
                        Text(
                          categoryLabel,
                          style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.secondary),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
                      ),
                      const SizedBox(height: AppDimens.stackGapSm),
                      Row(
                        children: [
                          Text(
                            course.formattedPrice,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colorScheme.primaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: AppDimens.stackGapSm),
                          const Icon(Icons.star, size: 14, color: AppColorTokens.tertiaryFixedDim),
                          const SizedBox(width: 2),
                          Text(
                            course.rating.toStringAsFixed(1),
                            style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
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
      ),
    );
  }
}
