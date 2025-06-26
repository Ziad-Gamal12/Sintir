import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestviewBody.dart';

class Coursetestview extends StatelessWidget {
  const Coursetestview(
      {super.key, required this.coursetestviewnavigationsrequirmentsentity});
  static const routename = "/Coursetestview";
  final Coursetestviewnavigationsrequirmentsentity
      coursetestviewnavigationsrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestItemCubit(
        sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
        testitemrepo: getIt<Testitemrepo>(),
        assetspickerrepo: getIt<Assetspickerrepo>(),
      ),
      child: Provider.value(
        value: coursetestviewnavigationsrequirmentsentity,
        child: Scaffold(
          appBar: CustomAppBar(
              appBartitle:
                  coursetestviewnavigationsrequirmentsentity.test.title),
          body: const CoursetestviewBody(),
        ),
      ),
    );
  }
}
