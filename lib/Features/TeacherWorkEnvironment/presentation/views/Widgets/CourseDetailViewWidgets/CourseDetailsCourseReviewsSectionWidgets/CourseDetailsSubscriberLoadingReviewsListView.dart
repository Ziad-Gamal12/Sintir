import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscriberReviewsListView_Item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsSubscriberLoadingReviewsListView extends StatelessWidget {
  const CourseDetailsSubscriberLoadingReviewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getFakeLoadingReviews().length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Skeletonizer(
          enabled: true,
          child: CourseDetailsSubscriberReviewsListViewItem(
              reviews: getFakeLoadingReviews()[index]),
        ),
      ),
    );
  }

  List<CoursefeedbackItemEntity> getFakeLoadingReviews() =>
      List.generate(6, (index) => CoursefeedbackItemEntity.empty());
}
