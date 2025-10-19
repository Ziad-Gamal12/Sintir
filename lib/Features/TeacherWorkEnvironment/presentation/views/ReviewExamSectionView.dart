import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/ReviewExamSectionViewBody.dart';

class ReviewExamSectionView extends StatelessWidget {
  const ReviewExamSectionView(
      {super.key, required this.navigateExamReviewRequirmentsEntity});
  static const routeName = '/reviewsqlexamview';
  final NavigateExamReviewRequirmentsEntity navigateExamReviewRequirmentsEntity;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TestItemCubit>(
          create: (context) => TestItemCubit(
            sectionItemsActionsRepo: getIt<SectionItemsActionsRepo>(),
            testitemrepo: getIt<Testitemrepo>(),
            assetspickerrepo: getIt<Assetspickerrepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => CourseSectionsCubit(
              getIt<CourseSectionsRepo>(), getIt<Assetspickerrepo>()),
        )
      ],
      child: Provider.value(
        value: navigateExamReviewRequirmentsEntity,
        child: const Scaffold(
          appBar: CustomAppBar(appBartitle: "مراجعه"),
          body: ReviewExamSectionViewBody(),
        ),
      ),
    );
  }
}
