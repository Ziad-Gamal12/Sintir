import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/ReviewSqlTestSectionViewBody.dart';

class ReviewSqlTestSectionView extends StatelessWidget {
  const ReviewSqlTestSectionView(
      {super.key, required this.navigatesqlreviewrequirmentsentity});
  static const routeName = '/reviewsqlexamview';
  final Navigatesqlreviewrequirmentsentity navigatesqlreviewrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseSectionsCubit(
          getIt<CourseSectionsRepo>(), getIt<Assetspickerrepo>()),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "مراجعه"),
        body: ReviewSqlTestSectionViewBody(
          navigatesqlreviewrequirmentsentity:
              navigatesqlreviewrequirmentsentity,
        ),
      ),
    );
  }
}
