import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsViewBody.dart';

class CourseDetailsCourseReportsView extends StatelessWidget {
  const CourseDetailsCourseReportsView({super.key, required this.courseId});
  static const routeName = '/CourseDetailsCourseReportsView';
  final String courseId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseReportsCubit(coursereportsrepo: getIt<CourseReportsRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: "الابلاغات"),
        body: CourseDetailsCourseReportsViewBody(
          courseId: courseId,
        ),
      ),
    );
  }
}
