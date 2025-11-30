import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddcoursesectionviewBody.dart';
import 'package:sintir/locale_keys.dart';

class Addcoursesectionview extends StatelessWidget {
  const Addcoursesectionview({super.key, required this.course});
  static const String routeName = '/Addcoursesectionview';
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    OptionNavigationRequirementsEntity optionnavigationrequirementsentity =
        OptionNavigationRequirementsEntity(
      isNewSection: true,
      courseEntity: course,
      section: CourseSectionEntity(
        title: "",
        subtitle: "",
        id: "${DateTime.now().toIso8601String()}-Section",
      ),
    );
    return BlocProvider(
      create: (context) => CourseSectionsCubit(
        getIt<CourseSectionsRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.addLecture),
        body: Provider.value(
          value: optionnavigationrequirementsentity,
          child: const Addcoursesectionviewbody(),
        ),
      ),
    );
  }
}
