import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/MyResults/Presentation/Manager/cubit/my_results_cubit.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/MyResultsViewBodyListViewLoading.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';

class MyResultsViewBodyListView extends StatefulWidget {
  const MyResultsViewBodyListView(
      {super.key, required this.myResults, required this.scrollController});
  final List<TestResultEntity> myResults;
  final ScrollController scrollController;
  @override
  State<MyResultsViewBodyListView> createState() =>
      _MyResultsViewBodyListViewState();
}

class _MyResultsViewBodyListViewState extends State<MyResultsViewBodyListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyResultsCubit, MyResultsState>(
        builder: (context, state) {
      if (state is GetMyResultsFailure) {
        return CustomErrorWidget(errormessage: state.errMessage);
      } else if (state is GetMyResultsLoading &&
          widget.myResults.isEmpty &&
          state.isPaginate == false) {
        return const MyResultsViewBodyListViewLoading();
      } else if (state is GetMyResultsSuccess && widget.myResults.isEmpty) {
        return CustomEmptyWidget(
          text: "لا يوجد نتائج لديك حتى الان",
        );
      } else {
        return ListView.builder(
          controller: widget.scrollController,
          itemCount: state is GetMyResultsLoading && state.isPaginate
              ? widget.myResults.length + 1
              : widget.myResults.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: index == widget.myResults.length
                ? const MyResultsViewBodyListViewLoading()
                : AspectRatio(
                    aspectRatio: 2 / 1.75,
                    child: StudentResultCard(
                      testResultEntity: widget.myResults[index],
                    ),
                  ),
          ),
        );
      }
    });
  }
}
