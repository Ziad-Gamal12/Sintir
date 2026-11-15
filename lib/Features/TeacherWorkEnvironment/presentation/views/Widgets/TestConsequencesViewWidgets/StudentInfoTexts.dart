import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatusChip.dart';

class StudentInfoTexts extends StatelessWidget {
  const StudentInfoTexts({
    super.key,
    required this.testResult,
    required this.statusColor,
  });

  final TestResultEntity testResult;
  final Color statusColor;

  /// Arabic-Indic digits -> Latin digits, so the date matches the rest of the
  /// screen (scores and percentages are already Latin).
  static String _latinDigits(String input) => input.replaceAllMapped(
        RegExp(r'[\u0660-\u0669]'),
        (m) => (m[0]!.codeUnitAt(0) - 0x0660).toString(),
      );

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final languageCode = Localizations.localeOf(context).languageCode;

    final name = testResult.joinedbyentity.name
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
    final date = _latinDigits(
      DateFormat.yMMMd(languageCode).format(testResult.joinedDate),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: style.semiBold16,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 10,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            StudentResultStatusChip(
              isPassed: testResult.isPassed,
              color: statusColor,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today_rounded, size: 14, color: muted),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style.regular12.copyWith(color: muted),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
