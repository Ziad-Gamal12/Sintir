import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HorizentalLoadingCoursesListView extends StatelessWidget {
  const HorizentalLoadingCoursesListView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final courses = CourseEntity.fakeCourses;
    return SizedBox(
      height: height * .28,
      child: ListView.builder(
          padding: const EdgeInsets.only(right: KHorizontalPadding),
          scrollDirection: Axis.horizontal,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AspectRatio(
                aspectRatio: 150 / 200,
                child: Skeletonizer(
                    enabled: true,
                    child: CustomCourseItem(
                        courseItem: courses[index], ontap: () {})),
              ),
            );
          }),
    );
  }
}
