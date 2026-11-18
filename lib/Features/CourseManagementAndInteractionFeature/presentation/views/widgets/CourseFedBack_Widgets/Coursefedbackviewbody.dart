import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/MyCourseRatingCubit/my_course_rating_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFeedbackSkeleton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseRatingSummaryCard.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/MyCourseRatingSection.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ReviewsSectionTitle.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class Coursefedbackviewbody extends StatefulWidget {
  const Coursefedbackviewbody({
    super.key,
    required this.requirmentsEntity,
    required this.currentUid,
  });
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;

  final String? currentUid;

  @override
  State<Coursefedbackviewbody> createState() => _CoursefedbackviewbodyState();
}

class _CoursefedbackviewbodyState extends State<Coursefedbackviewbody> {
  final ScrollController _scrollController = ScrollController();

  String get _courseId => widget.requirmentsEntity.course.id;

  bool get _canRate =>
      widget.requirmentsEntity.isSubscribed &&
      (widget.currentUid?.isNotEmpty ?? false);

  String? get _ratingUid => _canRate ? widget.currentUid : null;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_maybeLoadMore);
    context.read<CourseFeedBacksCubit>().getCourseFeedBacks(
      courseId: _courseId,
      isPaginate: false,
    );
    _loadRating();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadRating() =>
      context.read<MyCourseRatingCubit>().load(uid: _ratingUid);

  Future<void> _refresh() async {
    final feedBacks = context.read<CourseFeedBacksCubit>();
    final rating = context.read<MyCourseRatingCubit>();
    await Future.wait([
      feedBacks.refresh(courseId: _courseId),
      rating.load(uid: _ratingUid),
    ]);
  }

  void _maybeLoadMore() {
    if (!mounted || !_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.maxScrollExtent - position.pixels > 300) return;
    final cubit = context.read<CourseFeedBacksCubit>();
    final state = cubit.state;
    if (state is CourseFeedBacksGetFeedBackFailure &&
        (state.isPaginate || cubit.feedBacks.isEmpty)) {
      return;
    }
    if (cubit.hasMore && !cubit.isLoading) {
      cubit.getCourseFeedBacks(courseId: _courseId, isPaginate: true);
    }
  }

  bool _onScrollMetricsChanged(ScrollMetricsNotification notification) {
    if (notification.depth == 0) _maybeLoadMore();
    return false;
  }

  void _onRatingAction(BuildContext context, MyCourseRatingState state) {
    final feedBacksCubit = context.read<CourseFeedBacksCubit>();
    switch (state.action) {
      case CourseRatingAction.saved:
        final mine = state.myFeedback;
        if (mine != null) feedBacksCubit.upsertLocally(mine);
        CustomSnackBar.show(
          context,
          message: LocaleKeys.ratingSaved,
          type: SnackType.success,
        );
      case CourseRatingAction.deleted:
        final uid = widget.currentUid;
        if (uid != null) feedBacksCubit.removeLocally(uid);
        CustomSnackBar.show(
          context,
          message: LocaleKeys.reviewDeleted,
          type: SnackType.success,
        );
      case CourseRatingAction.deleteFailed:
        CustomSnackBar.show(
          context,
          message: state.errorMessage ?? LocaleKeys.errorOccurredMessage,
          type: SnackType.error,
        );
      case CourseRatingAction.idle:
      case CourseRatingAction.saving:
      case CourseRatingAction.saveFailed:
      case CourseRatingAction.deleting:
        break;
    }
  }

  void _onReviewsChanged(BuildContext context, CourseFeedBacksState state) {
    if (state is CourseFeedBacksGetFeedBackSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeLoadMore());
    } else if (state is CourseFeedBacksGetFeedBackFailure &&
        !state.isPaginate &&
        context.read<CourseFeedBacksCubit>().feedBacks.isNotEmpty) {
      CustomSnackBar.show(
        context,
        message: state.errMessage,
        type: SnackType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ratingReady = context.select<MyCourseRatingCubit, bool>(
      (cubit) => cubit.state.hasLoadedOnce,
    );
    final reviewsReady = context.select<CourseFeedBacksCubit, bool>(
      (cubit) => cubit.hasLoadedOnce,
    );
    final ready = ratingReady && reviewsReady;

    return MultiBlocListener(
      listeners: [
        BlocListener<MyCourseRatingCubit, MyCourseRatingState>(
          listenWhen: (previous, current) => previous.action != current.action,
          listener: _onRatingAction,
        ),
        BlocListener<CourseFeedBacksCubit, CourseFeedBacksState>(
          listener: _onReviewsChanged,
        ),
      ],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: ready
            ? _buildContent()
            : CourseFeedbackSkeleton(
                key: const ValueKey('course-feedback-skeleton'),
                showRateCard: _canRate,
              ),
      ),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      key: const ValueKey('course-feedback-content'),
      color: KMainColor,
      onRefresh: _refresh,
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: _onScrollMetricsChanged,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: _RatingHeader(
                  canRate: _canRate,
                  onRetrySummary: _loadRating,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: Coursefedbackslistview(
                courseId: _courseId,
                currentUid: widget.currentUid,
                excludeUid: _ratingUid,
                hideWhenEmpty: _canRate,
                header: const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 4),
                  child: ReviewsSectionTitle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingHeader extends StatelessWidget {
  const _RatingHeader({required this.canRate, required this.onRetrySummary});

  final bool canRate;
  final VoidCallback onRetrySummary;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCourseRatingCubit, MyCourseRatingState>(
      buildWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus ||
          previous.stats != current.stats,
      builder: (context, state) {
        final summary = switch (state.loadStatus) {
          CourseRatingLoadStatus.initial ||
          CourseRatingLoadStatus.loading =>
            const RatingSummaryLoadingPlaceholder(),
          CourseRatingLoadStatus.failure => _SummaryUnavailable(
            onRetry: onRetrySummary,
          ),
          CourseRatingLoadStatus.loaded =>
            state.stats.hasRatings
                ? CourseRatingSummaryCard(stats: state.stats)
                : null,
        };
        final sections = <Widget>[
          if (summary != null) summary,
          if (canRate) const MyCourseRatingSection(),
        ];
        if (sections.isEmpty) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < sections.length; index++) ...[
                if (index > 0) const SizedBox(height: 16),
                sections[index],
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SummaryUnavailable extends StatelessWidget {
  const _SummaryUnavailable({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.ratingSummaryUnavailable,
              style: AppTextStyles(
                context,
              ).regular14.copyWith(color: theme.textTheme.bodyMedium?.color),
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(LocaleKeys.reviewsRetry)),
        ],
      ),
    );
  }
}
