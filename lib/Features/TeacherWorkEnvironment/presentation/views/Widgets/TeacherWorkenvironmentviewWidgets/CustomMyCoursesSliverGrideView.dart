import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/CourseDetailView.dart';

class Custommycoursesslivergrideview extends StatelessWidget {
  const Custommycoursesslivergrideview({super.key, required this.courses});

  final List<CourseEntity> courses;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: courses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 155 / 198,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return CustomCourseItem(
            ontap: () {
              GoRouter.of(context)
                  .push(CourseDetailView.routeName, extra: courses[index]);
            },
            courseItem: courses[index],
          );
        });
  }
}
