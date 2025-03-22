import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/AddcoursesectionfileviewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class Addcoursesectionfileview extends StatelessWidget {
  const Addcoursesectionfileview({super.key, required this.courseEntity});
  static const routeName = '/Addcoursesectionfileview';
  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCourseSectionCubit(
        getIt<Addcoursesectionrepo>(),
        getIt<Assetspickerrepo>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "اضافة ملف"),
        body: Provider.value(
            value: courseEntity, child: const AddcoursesectionfileviewBody()),
      ),
    );
  }
}
