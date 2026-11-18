import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Bold course price, e.g. "150 ج.م". Paid courses use the primary color and
/// free courses the success color, so free ones are easy to spot.
class TeacherCoursePriceLabel extends StatelessWidget {
  const TeacherCoursePriceLabel({
    super.key,
    required this.label,
    required this.isFree,
  });

  final String label;
  final bool isFree;

  @override
  Widget build(BuildContext context) {
    final color = isFree
        ? WorkEnvironmentThemeExtension.of(context).successForeground
        : Theme.of(context).colorScheme.primary;

    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TeacherCourseCardMetrics.priceStyle(
        context,
      ).copyWith(color: color),
    );
  }
}
