import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamButtonAction.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamDetails.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamQuestionsHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamQuestionsSliverList.dart';
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
                      child: CustomReviewExamDetails(),
                    ),
                    SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1,
                        height: 40,
                        color: Colors.grey,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomReviewExamQuestionsHeader(),
                    ),
                    CustomReviewExamQuestionsSliverList(),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                      ),
                    ),
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
      CustomSnackBar.show(
        context,
        message: state.errMessage,
        type: SnackType.error,
      );
    } else if (state is AddTestItemFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddTestItemSuccess) {
      CustomSnackBar.show(
        context,
        message: "تمت الإضافة بنجاح",
        type: SnackType.success,
      );
      GoRouter.of(context).pop();
    }
  }

  void courseSectionListener(CourseSectionsState state, BuildContext context) {
    if (state is AddCourseSectionFailure) {
      CustomSnackBar.show(
        context,
        message: state.errMessage,
        type: SnackType.error,
      );
    } else if (state is AddCourseSectionSuccess) {
      CustomSnackBar.show(
        context,
        message: "تمت الإضافة بنجاح",
        type: SnackType.success,
      );
      GoRouter.of(context).pop();
    }
  }

  void questionsImagesUploadedSuccessState(BuildContext context) {
    NavigateExamReviewRequirmentsEntity navigatesqlreviewrequirmentsentity =
        context.read<NavigateExamReviewRequirmentsEntity>();
    if (navigatesqlreviewrequirmentsentity.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
          sectionItem: navigatesqlreviewrequirmentsentity.coursetestentity,
          courseId: navigatesqlreviewrequirmentsentity.courseEntity.id,
          section: navigatesqlreviewrequirmentsentity.section);
    } else {
      context.read<TestItemCubit>().addTestItem(
          courseId: navigatesqlreviewrequirmentsentity.courseEntity.id,
          sectionId: navigatesqlreviewrequirmentsentity.section.id,
          test: navigatesqlreviewrequirmentsentity.coursetestentity);
    }
  }
}
