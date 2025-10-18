import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ScoreStatCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ResultsAnalysisCardHighestScoreCard extends StatefulWidget {
  const ResultsAnalysisCardHighestScoreCard({super.key});

  @override
  State<ResultsAnalysisCardHighestScoreCard> createState() =>
      _ResultsAnalysisCardHighestScoreCardState();
}

class _ResultsAnalysisCardHighestScoreCardState
    extends State<ResultsAnalysisCardHighestScoreCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) {
        if (current is TestConsequencesGetHighestScorFailure ||
            current is TestConsequencesGetHighestScorLoading ||
            current is TestConsequencesGetHighestScorSuccess) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is TestConsequencesGetHighestScorFailure) {
          return Text(
            state.errMessage,
            style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
          );
        }
        return Skeletonizer(
          enabled: state is TestConsequencesGetHighestScorLoading,
          child: ScoreStatCard(
            label: "أعلى درجة",
            value: state is TestConsequencesGetHighestScorSuccess
                ? state.testResultEntity.result.toString()
                : "0",
            total: state is TestConsequencesGetHighestScorSuccess
                ? state.testResultEntity.totalQuestions.toString()
                : "0",
            color: Colors.green,
          ),
        );
      },
    );
  }
}
