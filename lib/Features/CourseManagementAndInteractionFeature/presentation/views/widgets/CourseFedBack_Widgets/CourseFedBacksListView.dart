import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView_item.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFeedbackSkeleton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ReportReviewSheet.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ReviewActionsMenu.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class Coursefedbackslistview extends StatelessWidget {
  const Coursefedbackslistview({
    super.key,
    required this.courseId,
    required this.currentUid,
    this.excludeUid,
    this.header,
    this.hideWhenEmpty = false,
  });

  final String courseId;

  final String? currentUid;

  final String? excludeUid;

  final Widget? header;

  final bool hideWhenEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFeedBacksCubit, CourseFeedBacksState>(
      builder: (context, state) {
        final cubit = context.read<CourseFeedBacksCubit>();
        final all = cubit.feedBacks;
        final feedBacks = excludeUid == null
            ? all
            : all.where((item) => item.uid != excludeUid).toList();
        final header = this.header;

        if (feedBacks.isEmpty) {
          final body = _emptyBody(state, cubit);
          if (body == null) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [if (header != null) header, body],
            ),
          );
        }

        final loadingMore =
            state is CourseFeedBacksGetFeedBackLoading && state.isPaginate;
        final pageFailed =
            state is CourseFeedBacksGetFeedBackFailure && state.isPaginate;
        final hasFooter = loadingMore || pageFailed;
        final dividerColor = Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.08);

        final list = SliverList.separated(
          itemCount: feedBacks.length + (hasFooter ? 1 : 0),
          separatorBuilder: (context, index) =>
              Divider(height: 1, thickness: 1, color: dividerColor),
          itemBuilder: (context, index) {
            if (index == feedBacks.length) {
              return loadingMore
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(color: KMainColor),
                      ),
                    )
                  : Center(
                      child: TextButton(
                        onPressed: () => cubit.getCourseFeedBacks(
                          courseId: courseId,
                          isPaginate: true,
                        ),
                        child: Text(LocaleKeys.reviewsRetry),
                      ),
                    );
            }
            final item = feedBacks[index];
            final isMine = currentUid != null && item.uid == currentUid;
            return CoursefedbackslistviewItem(
              key: ValueKey('course-feedback-${item.uid}'),
              item: item,
              isMine: isMine,
              trailing: currentUid == null || isMine
                  ? null
                  : ReviewActionsMenu(
                      hasReply: false,
                      onReport: () => _report(context, item.uid),
                    ),
            );
          },
        );
        if (header == null) return list;
        return SliverMainAxisGroup(
          slivers: [SliverToBoxAdapter(child: header), list],
        );
      },
    );
  }

  Future<void> _report(BuildContext context, String reviewUid) async {
    final repo = getIt<ReviewModerationRepo>();
    final sent = await ReportReviewSheet.show(
      context,
      onSubmit: (reason, details) async {
        final result = await repo.reportReview(
          courseId: courseId,
          reviewUid: reviewUid,
          reason: reason,
          details: details,
        );
        return result.fold((failure) => failure.message, (_) => null);
      },
    );
    if (sent && context.mounted) {
      CustomSnackBar.show(
        context,
        message: LocaleKeys.reviewReportSent,
        type: SnackType.success,
      );
    }
  }

  Widget? _emptyBody(CourseFeedBacksState state, CourseFeedBacksCubit cubit) {
    if (state is CourseFeedBacksInitial ||
        state is CourseFeedBacksGetFeedBackLoading) {
      return const ReviewsLoadingPlaceholder();
    }
    if (state is CourseFeedBacksGetFeedBackFailure) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: CustomErrorWidget(
          errormessage: state.errMessage,
          onRetry: () => cubit.getCourseFeedBacks(
            courseId: courseId,
            isPaginate: state.isPaginate,
          ),
        ),
      );
    }
    final onlyMine =
        excludeUid != null &&
        cubit.feedBacks.any((item) => item.uid == excludeUid);
    if (onlyMine) {
      return _EmptyReviews(title: LocaleKeys.noOtherReviewsYet);
    }
    if (hideWhenEmpty) return null;
    return _EmptyReviews(
      title: LocaleKeys.noReviewsYet,
      description: LocaleKeys.noReviewsYetDescription,
    );
  }
}

class _EmptyReviews extends StatelessWidget {
  const _EmptyReviews({required this.title, this.description});

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final description = this.description;
    return Padding(
      key: const ValueKey('reviews-empty'),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: styles.semiBold14.copyWith(
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 2),
            Text(
              description,
              style: styles.regular13.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
