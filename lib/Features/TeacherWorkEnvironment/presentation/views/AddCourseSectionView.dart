import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddcoursesectionviewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class Addcoursesectionview extends StatelessWidget {
  const Addcoursesectionview({super.key, required this.course});
  static const String routeName = '/Addcoursesectionview';
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCourseSectionCubit(getIt<Addcoursesectionrepo>()),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "اضافة محاضرة"),
        body: Addcoursesectionviewbody(
          courseEntity: course,
        ),
      ),
    );
  }
}
