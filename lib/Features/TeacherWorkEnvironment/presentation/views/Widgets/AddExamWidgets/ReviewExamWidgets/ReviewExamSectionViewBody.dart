import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Listeners/ReviewExamSectionViewBodyListener.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewExamDetails.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewExamQuestionsHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewExamQuestionsSliverList.dart';
import 'package:sintir/constant.dart';

class ReviewExamSectionViewBody extends StatefulWidget {
  const ReviewExamSectionViewBody({
    super.key,
    required this.navigateExamReviewRequirmentsEntity,
  });
  final NavigateExamReviewRequirmentsEntity navigateExamReviewRequirmentsEntity;

  @override
  State<ReviewExamSectionViewBody> createState() =>
      _ReviewExamSectionViewBodyState();
}

class _ReviewExamSectionViewBodyState extends State<ReviewExamSectionViewBody> {
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: widget.navigateExamReviewRequirmentsEntity,
      child: MultiBlocListener(
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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: TestSummaryCard(),
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
          )),
    );
  }
}
