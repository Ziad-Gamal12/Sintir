import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';

class LeatestCourseSliverGrid extends StatelessWidget {
  const LeatestCourseSliverGrid({super.key, required this.courses});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: courses.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount:
              GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
          childAspectRatio: GridHelper.getAspectRatio(
              maxWidth: MediaQuery.of(context).size.width),
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(),
            child: CustomCourseItem(
              courseItem: courses[index],
              ontap: () {
                showCustomBottomSheet(
                    child: CourseBottomSheet(
                      courseEntity: courses[index],
                    ),
                    context: context);
              },
            ),
          );
        });
  }
}
