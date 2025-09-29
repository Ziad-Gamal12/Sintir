// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsListView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsCourseReportsPageViewItem extends StatefulWidget {
  const CourseDetailsCourseReportsPageViewItem({
    super.key,
    required this.courseId,
    required this.scrollController,
  });

  final String courseId;
  final ScrollController scrollController;

  @override
  State<CourseDetailsCourseReportsPageViewItem> createState() =>
      _CourseDetailsCourseReportsPageViewItemState();
}

class _CourseDetailsCourseReportsPageViewItemState
    extends State<CourseDetailsCourseReportsPageViewItem> {
  List<CourseReportEntity> reports = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    // أول تحميل
    if (mounted) {
      context
          .read<CourseReportsCubit>()
          .getCourseReports(courseId: widget.courseId, isPaginate: false);

      // إضافة listener للـ ScrollController
      widget.scrollController.addListener(() {
        final cubit = context.read<CourseReportsCubit>();
        if (_shouldFetchMoreReports(cubit)) {
          cubit.getCourseReports(courseId: widget.courseId, isPaginate: true);
        }
      });
    }
  }

  bool _shouldFetchMoreReports(CourseReportsCubit cubit) {
    return widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! CourseReportsGetReportLoading;
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseReportsCubit, CourseReportsState>(
      listener: (context, state) {
        if (state is CourseReportsGetReportSuccess) {
          if (state.response.isPaginate) {
            setState(() {
              reports.addAll(state.response.reports);
            });
          } else {
            setState(() {
              reports = state.response.reports;
            });
          }
          hasMore = state.response.hasMore;
        }
      },
      builder: (context, state) {
        if (state is CourseReportsGetReportFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        }

        return Skeletonizer(
          enabled: state is CourseReportsGetReportLoading && reports.isEmpty,
          child: Column(
            children: [
              const SizedBox(height: 20),

              if (reports.isNotEmpty)
                CourseDetailsCourseReportsListView(reports: reports)
              else if (state is! CourseReportsGetReportLoading)
                const CustomEmptyWidget(),

              // loader للـ pagination
              if (state is CourseReportsGetReportLoading && reports.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
