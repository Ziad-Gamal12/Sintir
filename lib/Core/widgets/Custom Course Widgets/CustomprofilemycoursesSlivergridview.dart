// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class CustomprofilemycoursesSlivergridview extends StatelessWidget {
  const CustomprofilemycoursesSlivergridview(
      {super.key, required this.courses, required this.ontap});
  final List<CourseEntity> courses;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: courses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 155 / 198,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 40),
        itemBuilder: (context, index) {
          return CustomCourseItem(
            ontap: ontap,
            courseItem: courses[index],
          );
        });
  }
}
