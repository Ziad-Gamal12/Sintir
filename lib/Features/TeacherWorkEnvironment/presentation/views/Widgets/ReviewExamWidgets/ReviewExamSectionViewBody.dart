import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamButtonAction.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamNameAndDuration.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamQuestionsSliverList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomTitleAndDescriptionSectionInfo.dart';
import 'package:sintir/constant.dart';

class ReviewExamSectionViewBody extends StatelessWidget {
  const ReviewExamSectionViewBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<TestItemCubit, TestItemState>(
              listener: (context, state) {
            testItemBlocListener(state, context);
          }),
          BlocListener<CourseSectionsCubit, CourseSectionsState>(
              listener: (context, state) {
            courseSectionListener(state, context);
          })
        ],
        child: BlocBuilder<TestItemCubit, TestItemState>(
            builder: (context, state) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomTitleAndDescriptionSectionInfo(),
                    ),
                    SliverToBoxAdapter(
                      child: Divider(
                        color: Colors.black,
                        height: 40,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomReviewExamNameAndDuration(),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    CustomReviewExamQuestionsSliverList(),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: CustomReviewExamButtonAction(),
                )
              ],
            ),
          );
        }));
  }

  void testItemBlocListener(TestItemState state, BuildContext context) {
    if (state is QuestionsImagesUploadedingSuccuss) {
      questionsImagesUploadedSuccessState(context);
    } else if (state is QuestionsImagesUploadedingFailure) {
      ShowSnackBar(
          context: context,
          child: Text(state.errMessage,
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.red);
    } else if (state is AddTestItemFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddTestItemSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    }
  }

  void courseSectionListener(CourseSectionsState state, BuildContext context) {
    if (state is AddCourseSectionFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddCourseSectionSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    }
  }

  void questionsImagesUploadedSuccessState(BuildContext context) {
    NavigateExamReviewRequirmentsEntity navigatesqlreviewrequirmentsentity =
        context.read<NavigateExamReviewRequirmentsEntity>();
    if (navigatesqlreviewrequirmentsentity.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
          sectionItem: navigatesqlreviewrequirmentsentity.coursetestentity,
          courseId: navigatesqlreviewrequirmentsentity.courseID,
          section: navigatesqlreviewrequirmentsentity.section);
    } else {
      context.read<TestItemCubit>().addTestItem(
          courseId: navigatesqlreviewrequirmentsentity.courseID,
          sectionId: navigatesqlreviewrequirmentsentity.section.id,
          test: navigatesqlreviewrequirmentsentity.coursetestentity);
    }
  }
}
