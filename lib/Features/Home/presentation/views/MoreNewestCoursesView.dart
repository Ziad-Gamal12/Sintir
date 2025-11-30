import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/MoreNewestCoursesViewWidgets/MoreNewestCoursesViewBody.dart';
import 'package:sintir/locale_keys.dart';

class MoreNewestCoursesView extends StatelessWidget {
  const MoreNewestCoursesView({super.key});
  static String routeName = '/MoreNewestCoursesView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCoursesCubit(coursesrepo: getIt<Coursesrepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.latestCourses),
        body: const MoreNewestCoursesViewBody(),
      ),
    );
  }
}
