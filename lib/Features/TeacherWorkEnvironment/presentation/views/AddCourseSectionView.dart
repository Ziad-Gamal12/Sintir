import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddcoursesectionviewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class Addcoursesectionview extends StatelessWidget {
  const Addcoursesectionview({super.key, required this.course});
  static const String routeName = '/Addcoursesectionview';
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    Optionnavigationrequirementsentity optionnavigationrequirementsentity =
        Optionnavigationrequirementsentity(
      course: course,
      section: CoursSectionsListItemEntity(
        title: Variables.AddCoursesectionNameController.text,
        subtitle: Variables.AddCoursesesectionDescriptionController.text,
        items: [],
      ),
    );
    return BlocProvider(
      create: (context) => AddCourseSectionCubit(
          getIt<Addcoursesectionrepo>(), getIt<Assetspickerrepo>()),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "اضافة محاضرة"),
        body: Provider.value(
          value: optionnavigationrequirementsentity,
          child: const Addcoursesectionviewbody(),
        ),
      ),
    );
  }
}
