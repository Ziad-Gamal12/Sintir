// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsListView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsCourseReportsPageViewItem extends StatefulWidget {
  const CourseDetailsCourseReportsPageViewItem(
      {super.key,
      required this.courseId,
      required this.isFetchedCourseReports});
  final String courseId;
  final bool isFetchedCourseReports;

  @override
  State<CourseDetailsCourseReportsPageViewItem> createState() =>
      _CourseDetailsCourseReportsPageViewItemState();
}

class _CourseDetailsCourseReportsPageViewItemState
    extends State<CourseDetailsCourseReportsPageViewItem> {
  @override
  void initState() {
    super.initState();
    if (!widget.isFetchedCourseReports) {
      context
          .read<CourseReportsCubit>()
          .getCourseReports(courseId: widget.courseId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseReportsCubit, CourseReportsState,
        List<Coursereportsitementity>>(
      selector: (state) {
        if (state is CourseReportsGetReportSuccess) {
          return state.reports;
        }
        return [];
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is CourseReportsGetReportLoading,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (state.isNotEmpty)
                CourseDetailsCourseReportsListView(
                  reports: state,
                )
              else
                const CustomEmptyWidget()
            ],
          ),
        );
      },
    );
  }
}
