import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportActionsBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportResolutionNote.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetActionsTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetDescription.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSheetInfoCard.dart';

class ReportDetailsSheetBody extends StatelessWidget {
  const ReportDetailsSheetBody(
      {super.key, required this.courseId, required this.report});
  final String courseId;
  final CourseReportsItemEntity report;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReportSheetHeader(report: report),
        Divider(height: 1, color: Theme.of(context).dividerColor),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ReportSheetInfoCard(report: report),
                const SizedBox(height: 20),
                ReportSheetDescription(text: report.description),
                if (report.status != ReportStatus.open) ...[
                  const SizedBox(height: 12),
                  ReportResolutionNote(report: report),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 20),
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
      ],
    );
  }
}
