import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseReportsTabletHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDetailsPanel.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportFilterToolbar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportStatusFilterChips.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportsList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportsSummaryStrip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/states/ReportDetailEmptyView.dart';
import 'package:sintir/constant.dart';

class CourseReportsTabletLayout extends StatefulWidget {
  const CourseReportsTabletLayout(
      {super.key,
      required this.courseId,
      required this.width,
      required this.state});
  final String courseId;
  final double width;
  final CourseReportsState state;
  @override
  State<CourseReportsTabletLayout> createState() =>
      _CourseReportsTabletLayoutState();
}

class _CourseReportsTabletLayoutState extends State<CourseReportsTabletLayout> {
  String? selectedId;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseReportsCubit>();
    final reports = cubit.visibleReports;
    CourseReportsItemEntity? selected;
    for (final report in reports) {
      if (report.id == selectedId) {
        selected = report;
        break;
      }
    }
    selected ??= reports.isEmpty ? null : reports.first;
    final listFraction = widget.width >= 840 ? 4 : 5;
    return Column(children: [
      const CourseReportsTabletHeader(),
      ReportsSummaryStrip(
          summary: cubit.summary,
          includeDismissed: true,
          wrap: widget.width < 840),
      const SizedBox(height: 14),
      Expanded(
          child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  KHorizontalPadding, 0, KHorizontalPadding, KVerticalPadding),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: listFraction,
                        child: Column(children: [
                          const ReportStatusFilterChips(compact: true),
                          const SizedBox(height: 8),
                          const ReportFilterToolbar(isMobile: false),
                          const SizedBox(height: 6),
                          Expanded(
                              child: ReportsList(
                                  state: widget.state,
                                  onReportTap: (report) =>
                                      setState(() => selectedId = report.id))),
                        ])),
                    const SizedBox(width: 16),
                    Expanded(
                        flex: 10 - listFraction,
                        child: selected == null
                            ? const ReportDetailEmptyView()
                            : ReportDetailsPanel(
                                courseId: widget.courseId,
                                reportId: selected.id)),
                  ]))),
    ]);
  }
}
