import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/AdaptiveSliverGrid.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/get_exam_results_cubit/get_exam_results_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestResultsSliverListView extends StatelessWidget {
  const TestResultsSliverListView({super.key, required this.testResults});
  final List<TestResultEntity> testResults;

  static final List<TestResultEntity> _fakeResults = List.generate(
    6,
    (_) => TestResultEntity.empty(),
  );

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
        }
        if (state is GetExamResultsLoading &&
            state.isPaginate == false &&
            testResults.isEmpty) {
          return AdaptiveSliverGrid(
            itemCount: _fakeResults.length,
            itemBuilder: (_, i) => Skeletonizer(
              enabled: true,
              child: StudentResultCard(testResultEntity: _fakeResults[i]),
            ),
          );
        }
        if (state is GetExamResultsSuccess && testResults.isEmpty) {
          return SliverToBoxAdapter(
            child: CustomEmptyWidget(text: LocaleKeys.noResults),
          );
        }
        return AdaptiveSliverGrid(
          itemCount: testResults.length,
          itemBuilder: (_, i) =>
              StudentResultCard(testResultEntity: testResults[i]),
        );
      },
    );
  }
}
