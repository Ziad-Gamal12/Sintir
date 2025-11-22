import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';

class HorizentalCoursesListView extends StatelessWidget {
  const HorizentalCoursesListView({super.key, required this.courses});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * .28,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 12),
              child: AspectRatio(
                aspectRatio: 150 / 200,
                child: CustomCourseItem(
                    courseItem: courses[index],
                    ontap: () {
                      showCustomBottomSheet(
                          child: CourseBottomSheet(
                            courseEntity: courses[index],
                          ),
                          context: context);
                    }),
              ),
            );
          }),
    );
  }
}
