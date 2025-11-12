import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/MyCourses/Presentation/Manager/cubit/my_courses_cubit.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/Widgets/MyCoursesViewBody.dart';

class MyCoursesView extends StatelessWidget {
  const MyCoursesView({super.key});
  static String routeName = "/MyCoursesView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: "الدورات الخاصه بي"),
      body: BlocProvider(
          create: (context) => MyCoursesCubit(
                coursesrepo: getIt<Coursesrepo>(),
              ),
          child: const MyCoursesViewBody()),
    );
  }
}
