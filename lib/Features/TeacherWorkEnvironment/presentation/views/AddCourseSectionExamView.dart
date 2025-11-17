// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseSectionExamViewBody.dart';

class AddcourseSectionExamview extends StatefulWidget {
  const AddcourseSectionExamview(
      {super.key, required this.optionnavigationrequirementsentity});
  static const routeName = '/AddCourseSectionExamView';
  final OptionNavigationRequirementsEntity optionnavigationrequirementsentity;

  @override
  State<AddcourseSectionExamview> createState() =>
      _AddcourseSectionExamviewState();
}

class _AddcourseSectionExamviewState extends State<AddcourseSectionExamview>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => TestItemCubit(
          sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
          testitemrepo: getIt<Testitemrepo>(),
          assetspickerrepo: getIt<Assetspickerrepo>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(appBartitle: "اضافة امتحان"),
        body: Provider.value(
          value: widget.optionnavigationrequirementsentity,
          child: const AddCourseSectionExamViewBody(),
        ),
      ),
    );
  }
}
