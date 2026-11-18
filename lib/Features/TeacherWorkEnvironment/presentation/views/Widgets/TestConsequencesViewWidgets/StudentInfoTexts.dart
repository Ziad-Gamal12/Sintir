import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class StudentInfoTexts extends StatelessWidget {
  const StudentInfoTexts({
    super.key,
    required this.testResult,
    this.statusColor,
  });

  final TestResultEntity testResult;
  final Color? statusColor;

  static String formatSubmissionDateTime(DateTime date, String localeCode) {
    try {
      return DateFormat.yMMMd(localeCode).add_jm().format(date);
    } catch (_) {
      return DateFormat.yMd(localeCode).format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final style = AppTextStyles(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    final languageCode = Localizations.localeOf(context).languageCode;

    final rawName = testResult.joinedbyentity.name.trim();
    final name = rawName.isEmpty
        ? '—'
        : rawName.replaceAll(RegExp(r'\s+'), ' ');

    final formattedDate = formatSubmissionDateTime(
      testResult.joinedDate,
      languageCode,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: style.semiBold16.copyWith(color: theme.colorScheme.onSurface),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 3.5),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.schedule_rounded,
              size: 13,
              color: muted.withValues(alpha: isDark ? 0.70 : 0.80),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                '${LocaleKeys.submittedAt}: $formattedDate',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.regular12.copyWith(
                  color: muted.withValues(alpha: isDark ? 0.85 : 0.90),
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
