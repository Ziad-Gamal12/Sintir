import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubscriberEnrolledCoursesListViewLoading extends StatelessWidget {
  const SubscriberEnrolledCoursesListViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: CourseEntity.fakeCourses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AspectRatio(
            aspectRatio: 150 / 200,
            child: Skeletonizer(
              enabled: true,
              child: CustomCourseItem(
                  courseItem: CourseEntity.fakeCourses[index], ontap: () {}),
            ),
          ),
        );
      },
    );
  }
}
