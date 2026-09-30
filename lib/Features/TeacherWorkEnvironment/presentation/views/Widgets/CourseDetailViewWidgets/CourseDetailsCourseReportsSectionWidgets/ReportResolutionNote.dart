import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_date_formatter.dart';
import 'package:sintir/locale_keys.dart';

class ReportResolutionNote extends StatelessWidget {
  const ReportResolutionNote({super.key, required this.report});
  final CourseReportsItemEntity report;
  @override
  Widget build(BuildContext context) {
    if (report.status == ReportStatus.open) return const SizedBox.shrink();
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = report.resolvedAt ?? report.date;
    final formatted = ReportDateFormatter.date(date, locale);
    final text = report.status == ReportStatus.resolved
        ? LocaleKeys.reportResolvedOnFor(formatted)
        : LocaleKeys.reportDismissedOnFor(formatted);
    return Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(9),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8)),
        child: Text(text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant)));
  }
}
