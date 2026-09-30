import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDescriptionText.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportMetaRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportResolutionNote.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportStatusIndicator.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportTypeChip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_type_ui.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.report,
    required this.onTap,
  });
  final CourseReportsItemEntity report;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final open = report.status == ReportStatus.open;
    final color = report.type.color(context);
    final isDark = theme.brightness == Brightness.dark;
    return Semantics(
        button: true,
        label:
            '${report.type.label}. ${report.status.name}. ${report.description}',
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isDark ? Color(0xff343434) : Color(0xffD8DADE),
              )),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: open
                    ? BoxDecoration(
                        border: BorderDirectional(
                            start: BorderSide(color: color, width: 3)))
                    : null,
                padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 8,
                          children: [
                            ReportTypeChip(type: report.type),
                            ReportStatusIndicator(status: report.status),
                          ]),
                      const SizedBox(height: 9),
                      ReportDescriptionText(
                          description: report.description, muted: !open),
                      if (!open) ...[
                        const SizedBox(height: 6),
                        ReportResolutionNote(report: report)
                      ],
                      const SizedBox(height: 8),
                      const Divider(height: 1),
                      const SizedBox(height: 7),
                      ReportMetaRow(report: report),
                    ]),
              )),
        ));
  }
}
