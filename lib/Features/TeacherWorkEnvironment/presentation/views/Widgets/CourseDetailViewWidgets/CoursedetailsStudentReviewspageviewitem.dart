import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/Coursedetailsstudentreviewslistview.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsStudentsReviewsPageViewItem extends StatefulWidget {
  const CourseDetailsStudentsReviewsPageViewItem(
      {super.key, required this.courseId, required this.feedBacks});
  final String courseId;
  final List<CoursefeedbackItemEntity> feedBacks;
  @override
  State<CourseDetailsStudentsReviewsPageViewItem> createState() =>
      _CourseDetailsStudentsReviewsPageViewItemState();
}

class _CourseDetailsStudentsReviewsPageViewItemState
    extends State<CourseDetailsStudentsReviewsPageViewItem> {
  @override
  void initState() {
    super.initState();
    if (widget.feedBacks.isEmpty) {
      context
          .read<CourseFeedBacksCubit>()
          .getCourseFeedBacks(courseId: widget.courseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseFeedBacksCubit, CourseFeedBacksState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is CourseFeedBacksGetFeedBackLoading,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (widget.feedBacks.isNotEmpty)
                Coursedetailsstudentreviewslistview(
                  reviews: widget.feedBacks,
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
