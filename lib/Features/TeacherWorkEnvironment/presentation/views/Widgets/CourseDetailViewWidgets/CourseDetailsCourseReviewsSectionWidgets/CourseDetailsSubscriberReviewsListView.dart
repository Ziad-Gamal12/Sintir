import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscriberReviewsListView_Item.dart';

class CourseDetailsSubscriberReviewsListView extends StatelessWidget {
  const CourseDetailsSubscriberReviewsListView(
      {super.key, required this.reviews});
  final List<CoursefeedbackItemEntity> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) =>
          CourseDetailsSubscriberReviewsListViewItem(reviews: reviews[index]),
    );
  }
}
