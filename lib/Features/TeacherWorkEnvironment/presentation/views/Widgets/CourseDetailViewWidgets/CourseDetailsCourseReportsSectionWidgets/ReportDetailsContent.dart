import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDetailsContentBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDetailsSheetBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/states/ReportDetailEmptyView.dart';

class ReportDetailsContent extends StatelessWidget {
  const ReportDetailsContent(
      {super.key,
      required this.courseId,
      required this.reportId,
      this.fallbackReport,
      this.inBottomSheet = false});
  final String courseId;
  final String reportId;
  final CourseReportsItemEntity? fallbackReport;
  final bool inBottomSheet;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CourseReportsCubit, CourseReportsState>(
        buildWhen: (_, state) =>
            state is CourseReportsGetReportSuccess ||
            state is CourseReportsGetReportFailure ||
            state is CourseReportsUpdateStatusLoading ||
            state is CourseReportsUpdateStatusSuccess ||
            state is CourseReportsUpdateStatusFailure,
        builder: (context, _) {
          final report =
              context.read<CourseReportsCubit>().reportById(reportId) ??
                  fallbackReport;
          if (report == null) return const ReportDetailEmptyView();
          return inBottomSheet
              ? ReportDetailsSheetBody(courseId: courseId, report: report)
              : ReportDetailsContentBody(courseId: courseId, report: report);
        },
      );
}
