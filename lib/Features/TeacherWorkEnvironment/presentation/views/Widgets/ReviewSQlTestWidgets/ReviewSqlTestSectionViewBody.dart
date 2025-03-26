import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomReviewSQlTestButtonAction.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomReviewSqlQuestionsSLiverList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomReviewSqlTestNameAndDuration.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomTitleAndDescriptionSectionInfo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class ReviewSqlTestSectionViewBody extends StatelessWidget {
  const ReviewSqlTestSectionViewBody(
      {super.key, required this.navigatesqlreviewrequirmentsentity});
  final Navigatesqlreviewrequirmentsentity navigatesqlreviewrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseSectionCubit, AddCourseSectionState>(
      listener: (context, state) {
        reviewSQlTestBlocListener(state, context);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomTitleAndDescriptionSectionInfo(
                      courseSectionEntity:
                          navigatesqlreviewrequirmentsentity.section,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: Colors.black,
                      height: 40,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomReviewSqlTestNameAndDuration(
                        coursetestentity: navigatesqlreviewrequirmentsentity
                            .coursetestentity),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  Customreviewsqlquestionssliverlist(
                      questions: navigatesqlreviewrequirmentsentity
                          .coursetestentity.questions),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: CustomReviewSQlTestButtonAction(
                    navigatesqlreviewrequirmentsentity:
                        navigatesqlreviewrequirmentsentity),
              )
            ],
          ),
        );
      },
    );
  }

  void reviewSQlTestBlocListener(
      AddCourseSectionState state, BuildContext context) {
    if (state is UpdateCourseSectionsFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is UpdateCourseSectionsSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    } else if (state is QuestionsImagesUploadedingSuccuss) {
      questionsImagesUploadedSuccessState(context);
    }
  }

  void questionsImagesUploadedSuccessState(BuildContext context) {
    navigatesqlreviewrequirmentsentity.section.items
        .add(navigatesqlreviewrequirmentsentity.coursetestentity);
    navigatesqlreviewrequirmentsentity.courseEntity.coursSectionsListItemEntity!
        .add(navigatesqlreviewrequirmentsentity.section);
    context.read<AddCourseSectionCubit>().updateCourseSections(
        courseEntity: navigatesqlreviewrequirmentsentity.courseEntity);
  }
}
