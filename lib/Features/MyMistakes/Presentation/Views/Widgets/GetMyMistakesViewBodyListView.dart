import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItem.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/GetMyMistakesViewBodyListViewLoading.dart';

class GetMyMistakesViewBodyListView extends StatefulWidget {
  const GetMyMistakesViewBodyListView(
      {super.key, required this.myMistakes, required this.scrollController});
  final List<ExamResultSolvedQuestionEntity> myMistakes;
  final ScrollController scrollController;
  @override
  State<GetMyMistakesViewBodyListView> createState() =>
      _GetMyMistakesViewBodyListViewState();
}

class _GetMyMistakesViewBodyListViewState
    extends State<GetMyMistakesViewBodyListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyMistakesCubit, GetMyMistakesState>(
        builder: (context, state) {
      if (state is GetMyMistakesFailure) {
        return Center(child: CustomErrorWidget(errormessage: state.errmessage));
      } else if (state is GetMyMistakesLoading &&
          widget.myMistakes.isEmpty &&
          state.isPaginate == false) {
        return const GetMyMistakesViewBodyListViewLoading();
      } else if (state is GetMyMistakesSuccess && widget.myMistakes.isEmpty) {
        return CustomEmptyWidget(
          text: "لا يوجد اخطاء لديك حتى الان",
        );
      } else {
        return ListView.builder(
          controller: widget.scrollController,
          itemCount: state is GetMyMistakesLoading && state.isPaginate
              ? widget.myMistakes.length + 1
              : widget.myMistakes.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: index == widget.myMistakes.length
                ? const GetMyMistakesViewBodyListViewLoading()
                : CustomSolvedQuestionListItem(
                    index: index,
                    length: widget.myMistakes.length,
                    examResultSolvedQuestionEntity: widget.myMistakes[index],
                  ),
          ),
        );
      }
    });
  }
}
