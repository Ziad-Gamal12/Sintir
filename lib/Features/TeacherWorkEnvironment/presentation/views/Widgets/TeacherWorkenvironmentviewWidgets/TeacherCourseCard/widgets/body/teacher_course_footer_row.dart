import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_new_chip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_stat_item.dart';

/// Lessons/tests summary at the start and, for new courses, the "New" chip
/// at the end (where the design places it).
class TeacherCourseFooterRow extends StatelessWidget {
  const TeacherCourseFooterRow({
    super.key,
    required this.contentLabel,
    required this.isNew,
  });

  final String contentLabel;
  final bool isNew;

  /// The chip keeps its natural width but never takes more than this share
  /// of the row, so long locales or large text ellipsize instead of
  /// overflowing.
  static const double _maxChipShare = 0.45;

  @override
  Widget build(BuildContext context) {
    final summary = TeacherCourseStatItem(
      icon: Icons.menu_book_outlined,
      label: contentLabel,
      style: TeacherCourseCardMetrics.footerStyle(context),
    );

    if (!isNew) {
      return Align(alignment: AlignmentDirectional.centerStart, child: summary);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: summary,
              ),
            ),
            const SizedBox(width: TeacherCourseCardMetrics.inlineGap),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * _maxChipShare,
              ),
              child: const TeacherCourseNewChip(),
            ),
          ],
        );
      },
    );
  }
}
