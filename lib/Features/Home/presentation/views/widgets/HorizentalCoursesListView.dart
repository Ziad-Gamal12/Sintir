import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';

class HorizentalCoursesListView extends StatelessWidget {
  const HorizentalCoursesListView({super.key, required this.courses});
  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final itemWidth = ((screenWidth - 32) * .44).clamp(150.0, 230.0).toDouble();
    final itemHeight = CourseCardMetrics.heightForWidth(context, itemWidth);

    return SizedBox(
      height: itemHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: courses.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final course = courses[index];
          return SizedBox(
            width: itemWidth,
            child: CustomCourseItem(
              courseItem: course,
              ontap: () => showCustomBottomSheet(
                child: CourseBottomSheet(courseEntity: course),
                context: context,
              ),
            ),
          );
        },
      ),
    );
  }
}
