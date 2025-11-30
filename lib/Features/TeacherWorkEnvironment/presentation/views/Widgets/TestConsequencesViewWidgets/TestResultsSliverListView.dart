import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/get_exam_results_cubit/get_exam_results_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestResultsSliverListView extends StatefulWidget {
  const TestResultsSliverListView({super.key, required this.testResults});
  final List<TestResultEntity> testResults;

  @override
  State<TestResultsSliverListView> createState() =>
      _TestResultsSliverListViewState();
}

class _TestResultsSliverListViewState extends State<TestResultsSliverListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExamResultsCubit, GetExamResultsState>(
      builder: (context, state) {
        if (state is GetExamResultsFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: CustomErrorWidget(errormessage: state.errmessage),
            ),
          );
        } else if (state is GetExamResultsLoading &&
            state.isPaginate == false &&
            widget.testResults.isEmpty) {
          return SliverToBoxAdapter(
            child: ListView.builder(
                itemCount: getFakeTestResults().length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AspectRatio(
                        aspectRatio: 2 / 1.75,
                        child: Skeletonizer(
                            enabled: true,
                            child: StudentResultCard(
                              testResultEntity: getFakeTestResults()[index],
                            ))),
                  );
                }),
          );
        } else if (state is GetExamResultsSuccess &&
            widget.testResults.isEmpty) {
          return SliverToBoxAdapter(
            child: CustomEmptyWidget(
              text: LocaleKeys.noResults,
            ),
          );
        } else {
          return SliverList.builder(
              itemCount: widget.testResults.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AspectRatio(
                      aspectRatio: 2 / 1.75,
                      child: StudentResultCard(
                        testResultEntity: widget.testResults[index],
                      )),
                );
              });
        }
      },
    );
  }

  List<TestResultEntity> getFakeTestResults() {
    return List.generate(6, (index) => TestResultEntity.empty());
  }
}
