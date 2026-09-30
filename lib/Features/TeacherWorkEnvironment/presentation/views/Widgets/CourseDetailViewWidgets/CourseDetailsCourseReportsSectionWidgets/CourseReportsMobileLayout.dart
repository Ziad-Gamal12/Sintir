import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseReportsMobileHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDetailsSheet.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportFilterToolbar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportStatusFilterChips.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportsList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportsSummaryStrip.dart';
import 'package:sintir/constant.dart';

class CourseReportsMobileLayout extends StatelessWidget {
  const CourseReportsMobileLayout(
      {super.key, required this.courseId, required this.state});
  final String courseId;
  final CourseReportsState state;

  void openDetails(BuildContext context, CourseReportsItemEntity report) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<CourseReportsCubit>(),
        child: ReportDetailsSheet(courseId: courseId, report: report),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseReportsCubit>();
    return RefreshIndicator.adaptive(
      onRefresh: cubit.refresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 240 &&
              cubit.hasMore &&
              !cubit.isLoadingMore &&
              !cubit.isLoading) {
            cubit.loadMore();
          }
          return false;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const CourseReportsMobileHeader(),
                  ReportsSummaryStrip(
                    summary: cubit.summary,
                    includeDismissed: false,
                    wrap: false,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: KHorizontalPadding),
                    child: Column(
                      children: [
                        const ReportStatusFilterChips(compact: true),
                        const SizedBox(height: 4),
                        const ReportFilterToolbar(isMobile: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            ReportsList(
              state: state,
              onReportTap: (report) => openDetails(context, report),
              asSliver: true,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
