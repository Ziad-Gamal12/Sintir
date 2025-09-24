import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class Favouritecoursesgrideview extends StatelessWidget {
  const Favouritecoursesgrideview({super.key, required this.courses});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: courses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 157 / 200,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return CustomCourseItem(
            courseItem: courses[index],
            ontap: () {},
          );
        });
  }
}
