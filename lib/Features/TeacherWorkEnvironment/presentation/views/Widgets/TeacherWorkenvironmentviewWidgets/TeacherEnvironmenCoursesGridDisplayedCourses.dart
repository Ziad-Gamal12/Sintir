// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/CourseDetailView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/teacher_course_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentBreakpoints.dart';

class TeacherEnvironmenCoursesGridDisplayedCourses extends StatelessWidget {
  const TeacherEnvironmenCoursesGridDisplayedCourses({
    super.key,
    required this.coursesList,
    this.crossAxisCount,
  });

  final List<CourseEntity> coursesList;
  final int? crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.crossAxisExtent;
        final count =
            crossAxisCount ??
            TeacherWorkEnvironmentLayout.getGridColumnCount(availableWidth);
        const gap = TeacherWorkEnvironmentLayout.gridGap;
        final cellWidth = (availableWidth - (gap * (count - 1))) / count;
        final cardExtent = TeacherCourseCardMetrics.heightForWidth(
          context,
          cellWidth,
        );

        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisSpacing: gap,
            crossAxisSpacing: gap,
            mainAxisExtent: cardExtent,
          ),
          itemCount: coursesList.length,
          itemBuilder: (context, index) {
            final course = coursesList[index];
            return TeacherCourseCard(
              course: course,
              onTap: () {
                GoRouter.of(
                  context,
                ).push(CourseDetailView.routeName, extra: course);
              },
            );
          },
        );
      },
    );
  }
}
