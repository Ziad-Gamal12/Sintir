import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/report_status_filter_chip.dart';
import 'package:sintir/locale_keys.dart';

class ReportStatusFilterChips extends StatelessWidget {
  const ReportStatusFilterChips({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseReportsCubit, CourseReportsState>(
      buildWhen: (_, current) =>
          current is! CourseReportsAddReportLoading &&
          current is! CourseReportsAddReportSuccess &&
          current is! CourseReportsAddReportFailure,
      builder: (context, _) {
        final cubit = context.read<CourseReportsCubit>();
        final summary = cubit.summary;
        final current = cubit.statusFilter;

        final filters = <({ReportStatus? status, String label, int count})>[
          (
            status: null,
            label: LocaleKeys.reportFilterAll,
            count: summary.total
          ),
          (
            status: ReportStatus.open,
            label: LocaleKeys.reportOpen,
            count: summary.open
          ),
          (
            status: ReportStatus.resolved,
            label: LocaleKeys.reportResolved,
            count: summary.resolved
          ),
          (
            status: ReportStatus.dismissed,
            label: LocaleKeys.reportDismissed,
            count: summary.dismissed
          ),
        ];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              for (final filter in filters)
                ReportStatusFilterChip(
                  label: filter.label,
                  count: filter.count,
                  selected: current == filter.status,
                  compact: compact,
                  onTap: () {
                    if (current == filter.status) {
                      return;
                    }
                    cubit.applyFilters(
                      status: filter.status,
                      type: cubit.typeFilter,
                      sortOrder: cubit.sortOrder,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
