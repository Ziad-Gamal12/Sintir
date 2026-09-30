import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDismissConfirmDialog.dart';
import 'package:sintir/locale_keys.dart';

class ReportActionsBar extends StatelessWidget {
  const ReportActionsBar(
      {super.key,
      required this.courseId,
      required this.reportId,
      required this.status,
      this.vertical = false});
  final String courseId, reportId;
  final ReportStatus status;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseReportsCubit>();
    final theme = Theme.of(context);
    final resolved = FilledButton.icon(
      onPressed: () => cubit.updateReportStatus(
          courseId: courseId,
          reportId: reportId,
          newStatus: ReportStatus.resolved),
      icon: const Icon(Icons.check_circle_outline),
      label: Text(LocaleKeys.reportMarkResolved),
    );
    final dismiss = OutlinedButton.icon(
      onPressed: () async {
        if (await ReportDismissConfirmDialog.confirm(context)) {
          cubit.updateReportStatus(
              courseId: courseId,
              reportId: reportId,
              newStatus: ReportStatus.dismissed);
        }
      },
      icon: const Icon(Icons.block),
      label: Text(LocaleKeys.reportDismissAction),
      style: OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.error,
          side: BorderSide(color: theme.colorScheme.error)),
    );

    if (status != ReportStatus.open) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: FilledButton.icon(
          onPressed: () => cubit.updateReportStatus(
              courseId: courseId,
              reportId: reportId,
              newStatus: ReportStatus.open),
          icon: const Icon(Icons.restart_alt),
          label: Text(LocaleKeys.reportActionReopen),
        ),
      );
    }
    if (vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 56, child: resolved),
          const SizedBox(height: 10),
          SizedBox(height: 56, child: dismiss)
        ],
      );
    }
    return Wrap(spacing: 10, runSpacing: 8, children: [resolved, dismiss]);
  }
}
