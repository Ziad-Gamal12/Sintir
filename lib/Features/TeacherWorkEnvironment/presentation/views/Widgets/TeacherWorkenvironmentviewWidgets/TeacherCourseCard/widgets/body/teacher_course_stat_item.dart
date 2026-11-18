import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Muted icon + single-line label, e.g. "120 students" or "8 lessons".
class TeacherCourseStatItem extends StatelessWidget {
  const TeacherCourseStatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.style,
  });

  final IconData icon;
  final String label;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final color = WorkEnvironmentThemeExtension.of(context).mutedText;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: TeacherCourseCardMetrics.iconSize, color: color),
        const SizedBox(width: TeacherCourseCardMetrics.iconGap),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
