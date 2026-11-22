import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/responsive/drag_scroll_configuration.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalCoursesListLayout.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HorizentalLoadingCoursesListView extends StatelessWidget {
  const HorizentalLoadingCoursesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = CourseEntity.fakeCourses;
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
                return SizedBox(
                  width: layout.itemWidth,
                  child: Skeletonizer(
                    enabled: true,
                    child: CustomCourseItem(
                      courseItem: courses[index],
                      ontap: () {},
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
