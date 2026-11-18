import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportActionsBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportResolutionNote.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetActionsTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetDescription.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetMeta.dart';

class ReportDetailsSheetBody extends StatelessWidget {
  const ReportDetailsSheetBody({
    super.key,
    required this.courseId,
    required this.report,
  });
  final String courseId;
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReportSheetHeader(report: report),
        Divider(height: 1, color: scheme.surfaceTint.withValues(alpha: 0.12)),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ReportSheetDescription(text: report.description),
                const SizedBox(height: 14),
                ReportSheetMeta(report: report),
                if (report.status != ReportStatus.open) ...[
                  const SizedBox(height: 14),
                  ReportResolutionNote(report: report),
                ],
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: scheme.surfaceTint.withValues(alpha: 0.12),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
            child: ReportSheetActionsTheme(
              status: report.status,
              child: ReportActionsBar(
                courseId: courseId,
                reportId: report.id,
                status: report.status,
                vertical: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
