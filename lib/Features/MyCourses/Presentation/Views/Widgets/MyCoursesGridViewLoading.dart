import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyCoursesGridViewLoading extends StatelessWidget {
  const MyCoursesGridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: CourseEntity.fakeCourses.length,
        gridDelegate: CourseCardGridDelegate.of(context, spacing: 20),
        itemBuilder: (context, index) => Skeletonizer(
                child: CustomCourseItem(
              courseItem: CourseEntity.fakeCourses[index],
              ontap: () {},
            )));
  }
}
