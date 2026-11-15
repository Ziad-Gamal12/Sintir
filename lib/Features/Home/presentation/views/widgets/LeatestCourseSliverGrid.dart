import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';

class LeatestCourseSliverGrid extends StatelessWidget {
  const LeatestCourseSliverGrid({super.key, required this.courses});
  final List<CourseEntity> courses;

  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = GridHelper.getCrossAxisCount(
      MediaQuery.sizeOf(context).width,
    );
    return SliverLayoutBuilder(
      builder: (context, constraints) {
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
