import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_date_formatter.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_status_ui.dart';
import 'package:sintir/locale_keys.dart';

class ReportResolutionNote extends StatelessWidget {
  const ReportResolutionNote({super.key, required this.report});
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    if (report.status == ReportStatus.open) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final accent = report.status.color(context);
    final isResolved = report.status == ReportStatus.resolved;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formatted = ReportDateFormatter.date(
      report.resolvedAt ?? report.date,
      locale,
    );
    final text = isResolved
        ? LocaleKeys.reportResolvedOnFor(formatted)
        : LocaleKeys.reportDismissedOnFor(formatted);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(
            isResolved
                ? Icons.check_circle_outline_rounded
                : Icons.remove_circle_outline_rounded,
            size: 16,
            color: accent,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles(context).regular13.copyWith(
                color: scheme.onSurface.withValues(alpha: 0.87),
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
