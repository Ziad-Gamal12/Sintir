// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/skeleton/teacher_course_card_skeleton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentBreakpoints.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherEnvironmentGridLoadingCourses extends StatelessWidget {
  const TeacherEnvironmentGridLoadingCourses({super.key, this.crossAxisCount});

  final int? crossAxisCount;

  /// Enough rows to fill the first screen on any breakpoint.
  static const int _skeletonRows = 3;

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

        // One sliver-level Skeletonizer so a single shimmer sweeps across
        // every card instead of each card animating on its own.
        return Skeletonizer.sliver(
          enabled: true,
          child: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              mainAxisExtent: TeacherCourseCardMetrics.heightForWidth(
                context,
                cellWidth,
              ),
            ),
            itemCount: count * _skeletonRows,
            itemBuilder: (_, _) => const TeacherCourseCardSkeleton(),
          ),
        );
      },
    );
  }
}
