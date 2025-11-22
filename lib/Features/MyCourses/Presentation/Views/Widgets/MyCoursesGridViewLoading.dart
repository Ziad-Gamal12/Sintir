import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyCoursesGridViewLoading extends StatelessWidget {
  const MyCoursesGridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: CourseEntity.fakeCourses.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: GridHelper.getCrossAxisCount(maxWidth),
          childAspectRatio: GridHelper.getAspectRatio(maxWidth: maxWidth),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => Skeletonizer(
                child: CustomCourseItem(
              courseItem: CourseEntity.fakeCourses[index],
              ontap: () {},
            )));
  }
}
