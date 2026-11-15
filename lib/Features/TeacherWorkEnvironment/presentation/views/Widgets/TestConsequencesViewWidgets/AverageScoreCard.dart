import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultsAverageHero.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AverageScoreCard extends StatelessWidget {
  const AverageScoreCard({super.key, this.average});

  /// The REAL mean of all student results (null → not available yet).
  final double? average;

  @override
  Widget build(BuildContext context) {
    // The cubit is used only to read the test's total questions
    // (every TestResultEntity carries it) and the loading state.
    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) =>
          current is TestConsequencesGetHighestScorLoading ||
          current is TestConsequencesGetHighestScorSuccess ||
          current is TestConsequencesGetHighestScorFailure,
      builder: (context, state) {
        final isLoading = state is TestConsequencesGetHighestScorLoading;
        final int? total = state is TestConsequencesGetHighestScorSuccess
            ? state.testResultEntity.totalQuestions
            : null;

        return Skeletonizer(
          enabled: isLoading,
          child: ResultsAverageHero(
            label: LocaleKeys.averageResults,
            // Placeholders only so the skeleton draws the full layout.
            average: isLoading ? 1.5 : average,
            totalQuestions: isLoading ? 3 : total,
          ),
        );
      },
    );
  }
}

/// Mean of all `result` values, or null when there are no results.
extension TestResultsStats on Iterable<TestResultEntity> {
  double? get averageScore {
    if (isEmpty) return null;
    return fold<int>(0, (sum, r) => sum + r.result) / length;
  }
}
