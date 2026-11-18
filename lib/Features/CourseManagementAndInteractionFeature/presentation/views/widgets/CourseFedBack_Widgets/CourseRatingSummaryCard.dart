// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseRatingSummaryCard extends StatelessWidget {
  const CourseRatingSummaryCard({
    super.key,
    required this.stats,
    this.selectedStar,
    this.onStarSelected,
  });

  final CourseRatingStatsEntity stats;
  final int? selectedStar;
  final ValueChanged<int>? onStarSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final styles = AppTextStyles(context);
    final locale = Localizations.localeOf(context).languageCode;
    final averageText = stats.average.toStringAsFixed(1);
    final countText = LocaleKeys.ratingsCount(stats.ratingsCount, locale);
    final mutedColor = theme.textTheme.bodySmall?.color;

    return Container(
      key: const ValueKey('course-rating-summary'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Semantics(
            container: true,
            label: '${LocaleKeys.ratingOutOfFive(averageText)}, $countText',
            child: ExcludeSemantics(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 96, maxWidth: 120),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      averageText,
                      key: const ValueKey('course-rating-average'),
                      style: styles.bold40.copyWith(
                        color: theme.textTheme.bodyLarge?.color,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    StarRatingDisplay(rating: stats.average, size: 16),
                    const SizedBox(height: 6),
                    Text(
                      countText,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styles.regular12.copyWith(color: mutedColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var star = 5; star >= 1; star--)
                  _DistributionRow(
                    star: star,
                    count: stats.countFor(star),
                    share: stats.shareOf(star),
                    locale: locale,
                    selected: selectedStar == star,
                    onTap: onStarSelected,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DistributionRow extends StatelessWidget {
  const _DistributionRow({
    required this.star,
    required this.count,
    required this.share,
    required this.locale,
    this.selected = false,
    this.onTap,
  });

  final int star;
  final int count;
  final double share;
  final String locale;
  final bool selected;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final styles = AppTextStyles(context);
    final mutedColor = theme.textTheme.bodySmall?.color;
    final labelColor = selected ? theme.textTheme.bodyLarge?.color : mutedColor;
    final labelStyle = selected
        ? styles.semiBold12.copyWith(color: labelColor)
        : styles.regular12.copyWith(color: labelColor);
    final onTap = this.onTap;

    final row = Row(
      children: [
        SizedBox(
          width: 12,
          child: Text(
            '$star',
            textAlign: TextAlign.center,
            style: labelStyle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: share,
              minHeight: 8,
              color: StarRatingDisplay.starColor,
              backgroundColor: isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.08),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 20),
          child: Text(
            LocaleFormatter.number(count, locale),
            textAlign: TextAlign.end,
            style: labelStyle,
          ),
        ),
      ],
    );
    final label = '$star: ${LocaleKeys.ratingsCount(count, locale)}';

    if (onTap == null) {
      return Semantics(
        label: label,
        child: ExcludeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: row,
          ),
        ),
      );
    }

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: ExcludeSemantics(
        child: Material(
          key: ValueKey('rating-distribution-row-$star'),
          color: selected
              ? KMainColor.withValues(alpha: isDark ? 0.24 : 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => onTap(star),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: row,
            ),
          ),
        ),
      ),
    );
  }
}
