import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseReportsAdaptiveLayout.dart';

class CourseReportsSection extends StatefulWidget {
  const CourseReportsSection({super.key, required this.courseId});
  final String courseId;
  @override
  State<CourseReportsSection> createState() => _CourseReportsSectionState();
}

class _CourseReportsSectionState extends State<CourseReportsSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context
            .read<CourseReportsCubit>()
            .loadInitial(courseId: widget.courseId);
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CourseReportsCubit, CourseReportsState>(
        buildWhen: (_, state) =>
            state is CourseReportsGetReportLoading ||
            state is CourseReportsGetReportSuccess ||
            state is CourseReportsGetReportFailure ||
            state is CourseReportsUpdateStatusSuccess ||
            state is CourseReportsUpdateStatusFailure,
        builder: (context, state) => LayoutBuilder(
            builder: (context, constraints) => CourseReportsAdaptiveLayout(
                courseId: widget.courseId,
                width: constraints.maxWidth,
                state: state)),
      );
}
