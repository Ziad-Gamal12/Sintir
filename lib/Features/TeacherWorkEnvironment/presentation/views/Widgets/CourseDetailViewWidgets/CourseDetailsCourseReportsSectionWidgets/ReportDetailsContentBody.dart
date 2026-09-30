import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportActionsBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportReporterField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportResolutionNote.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportStatusIndicator.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportTypeChip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_type_ui.dart';
import 'package:sintir/locale_keys.dart';

class ReportDetailsContentBody extends StatelessWidget {
  const ReportDetailsContentBody(
      {super.key, required this.courseId, required this.report});
  final String courseId;
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final tint = report.type.color(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.reportDetailsTitle,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  ReportTypeChip(type: report.type),
                  ReportStatusIndicator(status: report.status)
                ]),
                const SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      spacing: 18,
                      runSpacing: 12,
                      children: [
                        ReportReporterField(
                          icon: Icons.person_outline,
                          label: LocaleKeys.reportSubmittedBy,
                          value:
                              '${LocaleKeys.reportStudent} · ${LocaleKeys.reportReporterHidden}',
                        ),
                        ReportReporterField(
                          icon: Icons.calendar_month_outlined,
                          label: LocaleKeys.reportSubmittedAt,
                          value: DateFormat('d MMMM yyyy, h:mm a', locale)
                              .format(report.date),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(LocaleKeys.reportFullText,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: SelectableText(report.description,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.65, color: theme.colorScheme.onSurface)),
                ),
                if (report.status != ReportStatus.open) ...[
                  const SizedBox(height: 12),
                  ReportResolutionNote(report: report),
                ],
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: tint.withValues(
                          alpha:
                              theme.brightness == Brightness.dark ? .12 : .07),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(LocaleKeys.reportStatusChangeHint,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
          child: ReportActionsBar(
              courseId: courseId,
              reportId: report.id,
              status: report.status,
              vertical: false),
        ),
      ],
    );
  }
}
