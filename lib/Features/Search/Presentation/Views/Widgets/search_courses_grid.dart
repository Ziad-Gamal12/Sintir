import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class SearchCoursesGrid extends StatelessWidget {
  const SearchCoursesGrid({super.key, required this.courses});
  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SliverGrid.builder(
      itemCount: courses.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GridHelper.getCrossAxisCount(width),
        childAspectRatio: GridHelper.getAspectRatio(maxWidth: width),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => CustomCourseItem(
        courseItem: courses[index],
        ontap: () {},
      ),
    );
  }
}
