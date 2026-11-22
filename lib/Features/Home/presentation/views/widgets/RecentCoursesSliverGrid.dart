import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalCoursesListLayout.dart';

class RecentCoursesSliverGrid extends StatelessWidget {
  const RecentCoursesSliverGrid({super.key, required this.courses});
  final List<CourseEntity> courses;

  static const double _spacing = HorizentalCoursesListLayout.gridSpacing;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = GridHelper.getCrossAxisCount(
          constraints.crossAxisExtent,
        );
        final itemWidth =
            (constraints.crossAxisExtent - _spacing * (crossAxisCount - 1)) /
            crossAxisCount;

        return SliverGrid.builder(
          itemCount: courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: _spacing,
            crossAxisSpacing: _spacing,
            mainAxisExtent: CourseCardMetrics.heightForWidth(
              context,
              itemWidth,
            ),
          ),
          itemBuilder: (context, index) {
            final course = courses[index];
            return CustomCourseItem(
              courseItem: course,
              ontap: () => showCustomBottomSheet(
                child: CourseBottomSheet(courseEntity: course),
                context: context,
              ),
            );
          },
        );
      },
    );
  }
}
