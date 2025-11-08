import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';

class ContentCreatorCoursesGridDisplayedCourses extends StatelessWidget {
  const ContentCreatorCoursesGridDisplayedCourses({
    super.key,
    required this.coursesList,
  });
  final List<CourseEntity> coursesList;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GridHelper.getCrossAxisCount(width),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: GridHelper.getAspectRatio(maxWidth: width),
      ),
      itemCount: coursesList.length,
      itemBuilder: (context, index) {
        return CustomCourseItem(
          ontap: () {
            showCustomBottomSheet(
                child: CourseBottomSheet(courseEntity: coursesList[index]),
                context: context);
          },
          courseItem: coursesList[index],
        );
      },
    );
  }
}
