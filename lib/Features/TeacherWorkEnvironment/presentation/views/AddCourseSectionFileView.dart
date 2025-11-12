import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/file_item_cubit/file_item_cubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/AddcoursesectionfileviewBody.dart';

class Addcoursesectionfileview extends StatelessWidget {
  const Addcoursesectionfileview(
      {super.key, required this.optionnavigationrequirementsentity});
  static const routeName = '/Addcoursesectionfileview';
  final OptionNavigationRequirementsEntity optionnavigationrequirementsentity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseSectionsCubit(
            getIt<CourseSectionsRepo>(),
          ),
        ),
        BlocProvider(
            create: (context) => FileItemCubit(
                sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
                fileItemRepo: getIt<FileItemRepo>(),
                assetspickerrepo: getIt<Assetspickerrepo>()))
      ],
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: "اضافة ملف"),
        body: Provider.value(
            value: optionnavigationrequirementsentity,
            child: const AddcoursesectionfileviewBody()),
      ),
    );
  }
}
