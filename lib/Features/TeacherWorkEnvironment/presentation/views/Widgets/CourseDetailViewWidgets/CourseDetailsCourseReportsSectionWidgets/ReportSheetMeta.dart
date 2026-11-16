import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/locale_keys.dart';

class ReportSheetMeta extends StatelessWidget {
  const ReportSheetMeta({super.key, required this.report});
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurface.withValues(alpha: 0.6);
    final textStyle = AppTextStyles(context).regular13.copyWith(color: muted);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = DateFormat('d MMMM yyyy', locale).format(report.date);
    final time = DateFormat('hh:mm a', locale).format(report.date);

    Widget item(IconData icon, String text) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: muted),
        const SizedBox(width: 6),
        Flexible(child: Text(text, style: textStyle)),
      ],
    );

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        item(
          Icons.person_outline,
          '${LocaleKeys.reportStudent} (${LocaleKeys.reportReporterHidden})',
        ),
        item(Icons.schedule_rounded, '$date  •  $time'),
      ],
    );
  }
}
