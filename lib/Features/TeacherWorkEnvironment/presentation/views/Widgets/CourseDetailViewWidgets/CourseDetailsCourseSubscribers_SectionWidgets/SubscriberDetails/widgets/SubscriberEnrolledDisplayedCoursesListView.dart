import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';

class SubscriberEnrolledDisplayedCoursesListView extends StatelessWidget {
  const SubscriberEnrolledDisplayedCoursesListView(
      {super.key, required this.courses});
  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AspectRatio(
            aspectRatio: 150 / 200,
            child: CustomCourseItem(courseItem: courses[index], ontap: () {}),
          ),
        );
      },
    );
  }
}
