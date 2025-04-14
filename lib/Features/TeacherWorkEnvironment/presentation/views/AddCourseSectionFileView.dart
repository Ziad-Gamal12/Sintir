import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/AddcoursesectionfileviewBody.dart';

class Addcoursesectionfileview extends StatelessWidget {
  const Addcoursesectionfileview(
      {super.key, required this.optionnavigationrequirementsentity});
  static const routeName = '/Addcoursesectionfileview';
  final Optionnavigationrequirementsentity optionnavigationrequirementsentity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseSectionsCubit(
        getIt<CourseSectionsRepo>(),
        getIt<Assetspickerrepo>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "اضافة ملف"),
        body: Provider.value(
            value: optionnavigationrequirementsentity,
            child: const AddcoursesectionfileviewBody()),
      ),
    );
  }
}
