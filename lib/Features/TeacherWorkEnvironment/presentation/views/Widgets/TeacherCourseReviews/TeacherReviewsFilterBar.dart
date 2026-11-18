// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_course_reviews_cubit/teacher_course_reviews_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class TeacherReviewsFilterBar extends StatelessWidget {
  const TeacherReviewsFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TeacherCourseReviewsCubit,
      TeacherCourseReviewsState,
      bool
    >(
      selector: (state) => !state.hasNoReviewsAtAll,
      builder: (context, visible) => visible
          ? const SliverPersistentHeader(
              pinned: true,
              delegate: _FilterBarDelegate(),
            )
          : const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}

class _FilterBarDelegate extends SliverPersistentHeaderDelegate {
  const _FilterBarDelegate();

  static const double _extent = 56;

  @override
  double get minExtent => _extent;

  @override
  double get maxExtent => _extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => _FilterBarContent(showDivider: overlapsContent || shrinkOffset > 0);

  @override
  bool shouldRebuild(covariant _FilterBarDelegate oldDelegate) => false;
}

class _FilterBarContent extends StatelessWidget {
  const _FilterBarContent({required this.showDivider});

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<TeacherCourseReviewsCubit>();
    return Material(
      key: const ValueKey('teacher-reviews-filter-bar'),
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<
                  TeacherCourseReviewsCubit,
                  TeacherCourseReviewsState
                >(
                  buildWhen: (previous, current) =>
                      previous.query != current.query ||
                      previous.stats != current.stats ||
                      previous.statsReady != current.statsReady,
                  builder: (context, state) => ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    children: [
                      _QueryChip(
                        key: const ValueKey('reviews-filter-newest'),
                        selected: state.query == CourseReviewsQuery.newest,
                        onSelected: () =>
                            cubit.selectQuery(CourseReviewsQuery.newest),
                        child: Text(LocaleKeys.reviewsFilterNewest),
                      ),
                      _QueryChip(
                        key: const ValueKey('reviews-filter-lowest'),
                        selected: state.query == CourseReviewsQuery.lowestRated,
                        onSelected: () =>
                            cubit.selectQuery(CourseReviewsQuery.lowestRated),
                        child: Text(LocaleKeys.reviewsFilterLowest),
                      ),
                      for (var star = 5; star >= 1; star--)
                        _StarChip(
                          star: star,
                          stats: state.statsReady ? state.stats : null,
                          selected: state.query.star == star,
                          onSelected: () => cubit.toggleStar(star),
                        ),
                    ],
                  ),
                ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: theme.brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.08),
            ),
        ],
      ),
    );
  }
}

class _StarChip extends StatelessWidget {
  const _StarChip({
    required this.star,
    required this.stats,
    required this.selected,
    required this.onSelected,
  });

  final int star;
  final CourseRatingStatsEntity? stats;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final stats = this.stats;
    final count = stats?.countFor(star);
    final locale = Localizations.localeOf(context).languageCode;
    final enabled = selected || count == null || count > 0;
    final label = count == null
        ? LocaleKeys.ratingOutOfFive('$star')
        : '${LocaleKeys.ratingOutOfFive('$star')}, '
              '${LocaleKeys.ratingsCount(count, locale)}';

    return _QueryChip(
      key: ValueKey('reviews-filter-star-$star'),
      selected: selected,
      onSelected: enabled ? onSelected : null,
      semanticLabel: label,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$star'),
          const SizedBox(width: 2),
          const Icon(
            Icons.star_rounded,
            size: 16,
            color: StarRatingDisplay.starColor,
          ),
          if (count != null) ...[
            const SizedBox(width: 6),
            Text(
              LocaleFormatter.number(count, locale),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _QueryChip extends StatelessWidget {
  const _QueryChip({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.child,
    this.semanticLabel,
  });

  final bool selected;
  final VoidCallback? onSelected;
  final Widget child;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSelected = this.onSelected;
    final semanticLabel = this.semanticLabel;
    final borderColor = selected
        ? KMainColor
        : (isDark
              ? Colors.white.withValues(alpha: 0.16)
              : Colors.black.withValues(alpha: 0.12));

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: ChoiceChip(
        label: semanticLabel == null
            ? child
            : Semantics(
                label: semanticLabel,
                child: ExcludeSemantics(child: child),
              ),
        selected: selected,
        showCheckmark: false,
        onSelected: onSelected == null ? null : (_) => onSelected(),
        labelStyle: AppTextStyles(context).semiBold13.copyWith(
          color: selected
              ? (isDark ? const Color(0xFF9DB4F5) : const Color(0xFF2F55C8))
              : theme.textTheme.bodyMedium?.color,
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedColor: KMainColor.withValues(alpha: isDark ? 0.24 : 0.12),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
