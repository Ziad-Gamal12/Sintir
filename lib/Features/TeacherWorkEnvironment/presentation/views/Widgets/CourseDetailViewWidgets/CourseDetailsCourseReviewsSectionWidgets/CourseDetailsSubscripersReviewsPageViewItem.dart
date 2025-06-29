import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscriberReviewsListView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsSubscripersReviewsPageViewItem extends StatefulWidget {
  const CourseDetailsSubscripersReviewsPageViewItem(
      {super.key,
      required this.courseId,
      required this.isFetchedCourseFeedBacks});
  final String courseId;
  final bool isFetchedCourseFeedBacks;

  @override
  State<CourseDetailsSubscripersReviewsPageViewItem> createState() =>
      _CourseDetailsSubscripersReviewsPageViewItemState();
}

class _CourseDetailsSubscripersReviewsPageViewItemState
    extends State<CourseDetailsSubscripersReviewsPageViewItem> {
  @override
  void initState() {
    super.initState();

    if (!widget.isFetchedCourseFeedBacks) {
      context
          .read<CourseFeedBacksCubit>()
          .getCourseFeedBacks(courseId: widget.courseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseFeedBacksCubit, CourseFeedBacksState,
        List<CoursefeedbackItemEntity>>(
      selector: (state) {
        if (state is CourseFeedBacksGetFeedBackSuccess) {
          return state.feedBacks;
        }
        return [];
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is CourseFeedBacksGetFeedBackLoading,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (state.isNotEmpty)
                CourseDetailsSubscriberReviewsListView(
                  reviews: state,
                )
              else
                const CustomEmptyWidget()
            ],
          ),
        );
      },
    );
  }
}
