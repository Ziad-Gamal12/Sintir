// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/AddcoursesectionvedioviewBody.dart';

class Addcoursesectionvedioview extends StatelessWidget {
  const Addcoursesectionvedioview(
      {super.key, required this.optionnavigationrequirementsentity});
  static const routeName = '/Addcoursesectionvedioview';
  final OptionNavigationRequirementsEntity optionnavigationrequirementsentity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context1) => CourseSectionsCubit(
            getIt<CourseSectionsRepo>(),
          ),
        ),
        BlocProvider(
          create: (context1) => VideoItemCubit(
            sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
            videoItemRepo: getIt<VideoItemRepo>(),
            assetspickerrepo: getIt<Assetspickerrepo>(),
          ),
        )
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CustomAppBar(appBartitle: "اضافة فيديو"),
          body: Provider.value(
              value: optionnavigationrequirementsentity,
              child: const Addcoursesectionvedioviewbody()),
        );
      }),
    );
  }
}
