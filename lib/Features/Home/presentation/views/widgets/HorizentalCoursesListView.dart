import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/responsive/drag_scroll_configuration.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalCoursesListLayout.dart';

class HorizentalCoursesListView extends StatelessWidget {
  const HorizentalCoursesListView({super.key, required this.courses});
  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = HorizentalCoursesListLayout.of(
          context,
          constraints.maxWidth,
        );
        return SizedBox(
          height: layout.height,
          child: DragScrollConfiguration(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: layout.clipBehavior,
              padding: layout.padding,
              itemCount: courses.length,
              separatorBuilder: (_, _) => SizedBox(width: layout.spacing),
              itemBuilder: (context, index) {
                final course = courses[index];
                return SizedBox(
                  width: layout.itemWidth,
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
          ),
        );
      },
    );
  }
}
