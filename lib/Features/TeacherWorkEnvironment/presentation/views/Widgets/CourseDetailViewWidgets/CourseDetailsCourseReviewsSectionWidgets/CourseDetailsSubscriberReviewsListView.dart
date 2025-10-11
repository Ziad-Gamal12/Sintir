import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscriberReviewsListView_Item.dart';
import 'package:sintir/constant.dart';

class CourseDetailsSubscriberReviewsListView extends StatelessWidget {
  const CourseDetailsSubscriberReviewsListView(
      {super.key, required this.reviews, required this.scrollController});
  final List<CoursefeedbackItemEntity> reviews;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          vertical: KVerticalPadding, horizontal: KHorizontalPadding),
      controller: scrollController,
      itemCount: reviews.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child:
            CourseDetailsSubscriberReviewsListViewItem(reviews: reviews[index]),
      ),
    );
  }
}
