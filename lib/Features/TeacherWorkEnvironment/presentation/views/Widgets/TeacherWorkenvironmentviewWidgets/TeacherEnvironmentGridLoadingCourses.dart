import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherEnvironmentGridLoadingCourses extends StatelessWidget {
  const TeacherEnvironmentGridLoadingCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<CourseEntity> coursesList = CourseEntity.fakeCourses;
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GridHelper.getCrossAxisCount(width),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: GridHelper.getAspectRatio(maxWidth: width),
      ),
      itemCount: coursesList.length,
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: true,
          child: CustomCourseItem(
            ontap: () {},
            courseItem: coursesList[index],
          ),
        );
      },
    );
  }
}
