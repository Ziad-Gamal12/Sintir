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
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddcoursesectionsqlviewBody.dart';

class Addcoursesectionsqlview extends StatefulWidget {
  const Addcoursesectionsqlview(
      {super.key, required this.optionnavigationrequirementsentity});
  static const routeName = '/Addcoursesectionsqlview';
  final Optionnavigationrequirementsentity optionnavigationrequirementsentity;

  @override
  State<Addcoursesectionsqlview> createState() =>
      _AddcoursesectionsqlviewState();
}

class _AddcoursesectionsqlviewState extends State<Addcoursesectionsqlview>
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
        appBar: const CustomAppBar(appBartitle: "SQL"),
        body: Provider.value(
          value: widget.optionnavigationrequirementsentity,
          child: const AddcoursesectionsqlviewBody(),
        ),
      ),
    );
  }
}
