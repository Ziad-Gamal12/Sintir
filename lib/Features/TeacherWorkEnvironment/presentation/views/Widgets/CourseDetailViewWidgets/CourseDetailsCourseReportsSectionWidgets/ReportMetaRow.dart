import 'package:flutter/material.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_date_formatter.dart';
import 'package:sintir/locale_keys.dart';

class ReportMetaRow extends StatelessWidget {
  const ReportMetaRow({super.key, required this.report});
  final CourseReportsItemEntity report;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    String translate(String key, {Map<String, String>? args}) =>
        key.tr(args: args);
    final date = ReportDateFormatter.dateWithRelative(
        report.date, DateTime.now(), locale, translate);
    return Row(children: [
      Text(LocaleKeys.reportStudent,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      const Spacer(),
      Text(date,
          textAlign: TextAlign.end,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
    ]);
  }
}
