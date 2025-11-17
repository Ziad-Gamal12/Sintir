import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Listeners/ReviewExamSectionViewBodyListener.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamButtonAction.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamDetails.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamQuestionsHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamQuestionsSliverList.dart';
import 'package:sintir/constant.dart';

class ReviewExamSectionViewBody extends StatefulWidget {
  const ReviewExamSectionViewBody({
    super.key,
  });

  @override
  State<ReviewExamSectionViewBody> createState() =>
      _ReviewExamSectionViewBodyState();
}

class _ReviewExamSectionViewBodyState extends State<ReviewExamSectionViewBody> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<TestItemCubit, TestItemState>(
              listener: (context, state) {
            ReviewExamSectionViewBodyListener(context)
                .testItemBlocListener(state, context);
          }),
          BlocListener<CourseSectionsCubit, CourseSectionsState>(
              listener: (context, state) {
            ReviewExamSectionViewBodyListener(context)
                .courseSectionListener(state, context);
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
}
