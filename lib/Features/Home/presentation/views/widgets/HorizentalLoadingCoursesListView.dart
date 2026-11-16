import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HorizentalLoadingCoursesListView extends StatelessWidget {
  const HorizentalLoadingCoursesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final itemWidth = ((screenWidth - 32) * .44).clamp(150.0, 230.0).toDouble();
    final itemHeight = CourseCardMetrics.heightForWidth(context, itemWidth);
    final courses = CourseEntity.fakeCourses;
    return SizedBox(
      height: itemHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return SizedBox(
            width: itemWidth,
            child: Skeletonizer(
              enabled: true,
              child: CustomCourseItem(courseItem: courses[index], ontap: () {}),
            ),
          );
        },
      ),
    );
  }
}
