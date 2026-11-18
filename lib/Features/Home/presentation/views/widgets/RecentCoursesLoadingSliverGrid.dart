import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentCoursesLoadingSliverGrid extends StatelessWidget {
  const RecentCoursesLoadingSliverGrid({super.key});
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
          itemBuilder: (context, index) => Skeletonizer(
            enabled: true,
            child: CustomCourseItem(
              courseItem: CourseEntity.fakeCourses[index],
              ontap: () {},
            ),
          ),
          itemCount: CourseEntity.fakeCourses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: _spacing,
            crossAxisSpacing: _spacing,
            mainAxisExtent: CourseCardMetrics.heightForWidth(
              context,
              itemWidth,
            ),
          ),
        );
      },
    );
  }
}
