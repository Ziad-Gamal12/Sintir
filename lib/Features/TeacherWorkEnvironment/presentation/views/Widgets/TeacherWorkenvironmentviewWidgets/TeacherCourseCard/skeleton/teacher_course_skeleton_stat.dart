import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/skeleton/teacher_course_skeleton_line.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton counterpart of `TeacherCourseStatItem`: icon dot + text bone.
class TeacherCourseSkeletonStat extends StatelessWidget {
  const TeacherCourseSkeletonStat({
    super.key,
    required this.style,
    this.widthFactor = 1,
  });

  final TextStyle style;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Bone.circle(size: TeacherCourseCardMetrics.iconSize),
        const SizedBox(width: TeacherCourseCardMetrics.iconGap),
        Expanded(
          child: TeacherCourseSkeletonLine(
            style: style,
            widthFactor: widthFactor,
          ),
        ),
      ],
    );
  }
}
