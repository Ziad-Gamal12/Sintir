import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Text-shaped bone that occupies exactly one line of [style], so the
/// skeleton has the same rhythm as the real card.
///
/// Width is a fraction of the available space, so bones stay proportional
/// on every column width instead of overflowing narrow cards.
class TeacherCourseSkeletonLine extends StatelessWidget {
  const TeacherCourseSkeletonLine({
    super.key,
    required this.style,
    this.widthFactor = 1,
  });

  final TextStyle style;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final glyphHeight = TeacherCourseCardMetrics.textScaler(
      context,
    ).scale(style.fontSize ?? 14);

    return SizedBox(
      height: TeacherCourseCardMetrics.lineExtent(context, style),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          child: Bone(height: glyphHeight * 0.8, uniRadius: 4),
        ),
      ),
    );
  }
}
