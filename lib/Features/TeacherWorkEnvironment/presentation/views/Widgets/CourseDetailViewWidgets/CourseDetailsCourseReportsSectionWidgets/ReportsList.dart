import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportsListSkeleton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportsLoadMoreIndicator.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/states/ReportsEmptyView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/states/ReportsErrorView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/states/ReportsNoResultsView.dart';

class ReportsList extends StatelessWidget {
  const ReportsList(
      {super.key,
      required this.state,
      required this.onReportTap,
      this.asSliver = false});
  final CourseReportsState state;
  final ValueChanged<CourseReportsItemEntity> onReportTap;
  final bool asSliver;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseReportsCubit>();
    final all = cubit.reports;
    final reports = cubit.visibleReports;
    final initialLoading = state is CourseReportsGetReportLoading &&
        !(state as CourseReportsGetReportLoading).isPaginate &&
        all.isEmpty;
    if (initialLoading) {
      return asSliver
          ? const ReportsListSkeleton(asSliver: true)
          : const ReportsListSkeleton();
    }

    if (state is CourseReportsGetReportFailure && all.isEmpty) {
      final empty = ReportsErrorView(
        message: (state as CourseReportsGetReportFailure).errMessage,
        onRetry: cubit.refresh,
      );
      return asSliver
          ? SliverFillRemaining(hasScrollBody: false, child: empty)
          : _refreshable(cubit.refresh, empty);
    }
    if (all.isEmpty) {
      final view = ReportsEmptyView(onRetry: cubit.refresh);
      return asSliver
          ? SliverFillRemaining(hasScrollBody: false, child: view)
          : _refreshable(cubit.refresh, view);
    }
    if (reports.isEmpty) {
      final empty = ReportsNoResultsView(onClear: cubit.clearFilters);
      return asSliver
          ? SliverFillRemaining(hasScrollBody: false, child: empty)
          : _refreshable(cubit.refresh, empty);
    }

    final count = reports.length + (cubit.isLoadingMore ? 1 : 0);
    Widget itemBuilder(BuildContext context, int index) {
      if (index == reports.length) return const ReportsLoadMoreIndicator();
      final report = reports[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ReportCard(
          key: ValueKey(report.id),
          report: report,
          onTap: () => onReportTap(report),
        ),
      );
    }

    if (asSliver) {
      return SliverPadding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 16),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(itemBuilder, childCount: count),
        ),
      );
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 200 &&
            cubit.hasMore &&
            !cubit.isLoadingMore &&
            !cubit.isLoading) {
          cubit.loadMore();
        }
        return false;
      },
      child: RefreshIndicator.adaptive(
        onRefresh: cubit.refresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 16),
          itemCount: count,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }

  Widget _refreshable(Future<void> Function() onRefresh, Widget child) =>
      RefreshIndicator.adaptive(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [SizedBox(height: 260, child: child)],
        ),
      );
}
