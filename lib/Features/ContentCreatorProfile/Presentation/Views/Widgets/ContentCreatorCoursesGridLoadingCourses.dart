import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ContentCreatorCoursesGridLoadingCourses extends StatelessWidget {
  const ContentCreatorCoursesGridLoadingCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CourseEntity> coursesList = CourseEntity.fakeCourses;
    return SliverGrid.builder(
      gridDelegate: CourseCardGridDelegate.of(context, spacing: 20),
      itemCount: coursesList.length,
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: true,
          child: CustomCourseItem(
            ontap: () {},
            courseItem: coursesList[index],
          ),
        );
      },
    );
  }
}
