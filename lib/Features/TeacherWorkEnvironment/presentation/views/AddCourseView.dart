import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/AddCourseViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';

class Addcourseview extends StatefulWidget {
  const Addcourseview({super.key});
  static const routeName = '/Addcourseview';

  @override
  State<Addcourseview> createState() => _AddcourseviewState();
}

class _AddcourseviewState extends State<Addcourseview> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCourseCubitCubit(
          coursesrepo: getIt<Coursesrepo>(),
          assetspickerrepo: getIt<Assetspickerrepo>()),
      child: const Scaffold(
        appBar: CustomAppBar(
          appBartitle: "اضافة دورة",
        ),
        body: AddCourseViewBody(),
      ),
    );
  }
}
