import 'package:flutter/material.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_date_formatter.dart';
import 'package:sintir/locale_keys.dart';

class ReportMetaRow extends StatelessWidget {
  const ReportMetaRow({super.key, required this.report});
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = scheme.onSurface.withValues(alpha: 0.6);
    final locale = Localizations.localeOf(context).toLanguageTag();
    String translate(String key, {Map<String, String>? args}) =>
        key.tr(args: args);

    final reportedAt = ReportDateFormatter.dateWithRelative(
      report.date,
      DateTime.now(),
      locale,
      translate,
    );

    String? resolution;
    if (report.status != ReportStatus.open) {
      final formatted = ReportDateFormatter.date(
        report.resolvedAt ?? report.date,
        locale,
      );
      resolution = report.status == ReportStatus.resolved
          ? LocaleKeys.reportResolvedOnFor(formatted)
          : LocaleKeys.reportDismissedOnFor(formatted);
    }

    return Row(
      children: [
        Icon(Icons.schedule_rounded, size: 15, color: muted),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            [reportedAt, if (resolution != null) resolution].join('  •  '),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context).regular12.copyWith(color: muted),
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.chevron_right_rounded, size: 20, color: muted),
      ],
    );
  }
}
