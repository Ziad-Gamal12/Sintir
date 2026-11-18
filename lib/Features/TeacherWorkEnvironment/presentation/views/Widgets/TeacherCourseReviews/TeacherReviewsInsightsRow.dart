// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsInsights.dart';
import 'package:sintir/locale_keys.dart';

class TeacherReviewsInsightsRow extends StatelessWidget {
  const TeacherReviewsInsightsRow({super.key, required this.insights});

  final CourseReviewsInsights insights;

  @override
  Widget build(BuildContext context) {
    final newCount = insights.newCount;
    final recent = _InsightTile(
      key: const ValueKey('reviews-recent-tile'),
      title: LocaleKeys.reviewsLast30Days,
      child: _RecentRatings(insights: insights),
    );
    if (newCount == null) return recent;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: recent),
          const SizedBox(width: 12),
          Expanded(
            child: _InsightTile(
              key: const ValueKey('reviews-new-tile'),
              title: LocaleKeys.reviewsSinceLastVisit,
              child: _NewSinceVisit(
                count: newCount,
                partial: insights.newCountIsPartial,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Semantics(
        container: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles(
                context,
              ).regular12.copyWith(color: theme.textTheme.bodySmall?.color),
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }
}

class _RecentRatings extends StatelessWidget {
  const _RecentRatings({required this.insights});

  final CourseReviewsInsights insights;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final mutedColor = theme.textTheme.bodySmall?.color;
    if (!insights.hasRecentRatings) {
      return Text(
        LocaleKeys.reviewsRecentNone,
        style: styles.regular13.copyWith(color: mutedColor),
      );
    }
    final locale = Localizations.localeOf(context).languageCode;
    final average = insights.recentAverage.toStringAsFixed(1);
    final count = LocaleKeys.ratingsCount(insights.recentRatingsCount, locale);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: '${LocaleKeys.ratingOutOfFive(average)}, $count',
          child: ExcludeSemantics(
            child: Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: StarRatingDisplay.starColor,
                ),
                const SizedBox(width: 4),
                Text(
                  average,
                  key: const ValueKey('reviews-recent-average'),
                  style: styles.bold18.copyWith(
                    color: theme.textTheme.bodyLarge?.color,
                    height: 1.2,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    count,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.regular12.copyWith(color: mutedColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        _TrendLabel(trend: insights.trend),
      ],
    );
  }
}

class _TrendLabel extends StatelessWidget {
  const _TrendLabel({required this.trend});

  final CourseReviewsTrend trend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final muted = theme.textTheme.bodySmall?.color;
    final IconData icon;
    final String label;
    final Color? color;
    switch (trend) {
      case CourseReviewsTrend.up:
        icon = Icons.trending_up_rounded;
        label = LocaleKeys.reviewsTrendUp;
        color = isDark ? const Color(0xFF81C995) : const Color(0xFF137333);
      case CourseReviewsTrend.down:
        icon = Icons.trending_down_rounded;
        label = LocaleKeys.reviewsTrendDown;
        color = isDark ? const Color(0xFFF28B82) : const Color(0xFFC5221F);
      case CourseReviewsTrend.steady:
        icon = Icons.trending_flat_rounded;
        label = LocaleKeys.reviewsTrendSteady;
        color = muted;
      case CourseReviewsTrend.unknown:
        icon = Icons.info_outline_rounded;
        label = LocaleKeys.reviewsTrendFew;
        color = muted;
    }
    return Row(
      key: ValueKey('reviews-trend-${trend.name}'),
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context).semiBold12.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

class _NewSinceVisit extends StatelessWidget {
  const _NewSinceVisit({required this.count, required this.partial});

  final int count;
  final bool partial;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final locale = Localizations.localeOf(context).languageCode;
    final hasNew = count > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.reviewsNewCount(count, locale, partial: partial),
          key: const ValueKey('reviews-new-count'),
          style: styles.semiBold14.copyWith(
            color: hasNew
                ? theme.textTheme.bodyLarge?.color
                : theme.textTheme.bodySmall?.color,
          ),
        ),
        if (hasNew) ...[
          const SizedBox(height: 4),
          Text(
            LocaleKeys.reviewsNewMarkedHint,
            style: styles.regular12.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ],
    );
  }
}
