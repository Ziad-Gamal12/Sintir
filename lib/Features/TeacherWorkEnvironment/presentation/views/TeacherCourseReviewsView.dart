// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherCourseReviewsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherCourseReviews/TeacherCourseReviewsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_course_reviews_cubit/teacher_course_reviews_cubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherCourseReviewsView extends StatelessWidget {
  const TeacherCourseReviewsView({super.key, required this.course});

  static const routeName = '/TeacherCourseReviewsView';

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TeacherCourseReviewsCubit(
        repo: getIt<TeacherCourseReviewsRepo>(),
        courseId: course.id,
        moderation: getIt<ReviewModerationRepo>(),
      )..load(),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.studentsReviews),
        body: const SafeArea(top: false, child: TeacherCourseReviewsViewBody()),
      ),
    );
  }
}
