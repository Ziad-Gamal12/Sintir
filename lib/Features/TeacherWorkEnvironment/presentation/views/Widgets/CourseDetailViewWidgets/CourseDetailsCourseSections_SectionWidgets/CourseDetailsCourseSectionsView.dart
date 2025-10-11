import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsViewBody.dart';

class CourseDetailsCourseSectionsView extends StatelessWidget {
  const CourseDetailsCourseSectionsView(
      {super.key, required this.courseEntity});
  final CourseEntity courseEntity;
  static const String routeName = "/CourseDetailsCourseSectionsView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseSectionsCubit(
          getIt<CourseSectionsRepo>(), getIt<Assetspickerrepo>()),
      child: Scaffold(
        key: Variables.courseDeatilsViewScaffoldKey,
        appBar: const CustomAppBar(appBartitle: "المحتوى"),
        body: CourseDetailsCourseSectionsViewBody(
          courseEntity: courseEntity,
        ),
      ),
    );
  }
}
