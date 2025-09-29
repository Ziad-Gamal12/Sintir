import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscriberReviewsListView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsSubscribersReviewsPageViewItem extends StatefulWidget {
  const CourseDetailsSubscribersReviewsPageViewItem({
    super.key,
    required this.courseId,
    required this.scrollController,
  });

  final String courseId;
  final ScrollController scrollController;

  @override
  State<CourseDetailsSubscribersReviewsPageViewItem> createState() =>
      _CourseDetailsSubscribersReviewsPageViewItemState();
}

class _CourseDetailsSubscribersReviewsPageViewItemState
    extends State<CourseDetailsSubscribersReviewsPageViewItem> {
  List<CoursefeedbackItemEntity> feedbacks = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      context
          .read<CourseFeedBacksCubit>()
          .getCourseFeedBacks(courseId: widget.courseId, isPaginate: false);

      widget.scrollController.addListener(() {
        final cubit = context.read<CourseFeedBacksCubit>();
        if (_shouldFetchMore(cubit)) {
          cubit.getCourseFeedBacks(courseId: widget.courseId, isPaginate: true);
        }
      });
    }
  }

  bool _shouldFetchMore(CourseFeedBacksCubit cubit) {
    return widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! CourseFeedBacksGetFeedBackLoading;
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseFeedBacksCubit, CourseFeedBacksState>(
      listener: (context, state) {
        if (state is CourseFeedBacksGetFeedBackSuccess) {
          if (state.response.isPaginate) {
            setState(() {
              feedbacks.addAll(state.response.feedBacks);
            });
          } else {
            setState(() {
              feedbacks = state.response.feedBacks;
            });
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        if (state is CourseFeedBacksGetFeedBackFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        }
        return Skeletonizer(
          enabled:
              state is CourseFeedBacksGetFeedBackLoading && feedbacks.isEmpty,
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (feedbacks.isNotEmpty)
                CourseDetailsSubscriberReviewsListView(reviews: feedbacks)
              else if (state is! CourseFeedBacksGetFeedBackLoading)
                const CustomEmptyWidget(),
              if (state is CourseFeedBacksGetFeedBackLoading &&
                  feedbacks.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
