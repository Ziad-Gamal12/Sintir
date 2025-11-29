import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscribersReviewsViewBody.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailsSubscribersReviewsView extends StatelessWidget {
  const CourseDetailsSubscribersReviewsView(
      {super.key, required this.courseId});
  static const routeName = '/CourseDetailsSubscribersReviewsView';
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseFeedBacksCubit(
          courseFeedBacksRepo: getIt<CourseFeedBacksRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.studentsReviews),
        body: CourseDetailsSubscribersReviewsViewBody(
          courseId: courseId,
        ),
      ),
    );
  }
}
