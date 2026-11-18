import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_price_label.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_stat_item.dart';

/// Price at the start, students count at the end.
///
/// The students item keeps its natural width but never takes more than half
/// the row, so the price always stays readable on narrow cards.
class TeacherCoursePriceRow extends StatelessWidget {
  const TeacherCoursePriceRow({
    super.key,
    required this.priceLabel,
    required this.isFree,
    required this.studentsLabel,
  });

  final String priceLabel;
  final bool isFree;
  final String studentsLabel;

  static const double _maxStudentsShare = 0.5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: TeacherCoursePriceLabel(label: priceLabel, isFree: isFree),
            ),
            const SizedBox(width: TeacherCourseCardMetrics.inlineGap),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * _maxStudentsShare,
              ),
              child: TeacherCourseStatItem(
                icon: Icons.people_alt_outlined,
                label: studentsLabel,
                style: TeacherCourseCardMetrics.metaStyle(context),
              ),
            ),
          ],
        );
      },
    );
  }
}
