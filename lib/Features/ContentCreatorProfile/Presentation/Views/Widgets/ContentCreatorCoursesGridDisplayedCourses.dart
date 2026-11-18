import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';

class ContentCreatorCoursesGridDisplayedCourses extends StatelessWidget {
  const ContentCreatorCoursesGridDisplayedCourses({
    super.key,
    required this.coursesList,
  });
  final List<CourseEntity> coursesList;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: CourseCardGridDelegate.of(context, spacing: 20),
      itemCount: coursesList.length,
      itemBuilder: (context, index) {
        return CustomCourseItem(
          ontap: () {
            showCustomBottomSheet(
                child: CourseBottomSheet(courseEntity: coursesList[index]),
                context: context);
          },
          courseItem: coursesList[index],
        );
      },
    );
  }
}
