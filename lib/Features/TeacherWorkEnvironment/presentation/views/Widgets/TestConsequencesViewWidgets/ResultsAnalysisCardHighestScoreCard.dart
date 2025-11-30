import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ScoreStatCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';
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
          return Expanded(
            child: Text(
              state.errMessage,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles(context).regular14.copyWith(color: Colors.red),
            ),
          );
        }
        return Skeletonizer(
          enabled: state is TestConsequencesGetHighestScorLoading,
          child: InkWell(
            onTap: () {
              if (state is TestConsequencesGetHighestScorSuccess) {
                showCustomModalBottomSheet(
                    child: IntrinsicHeight(
                      child: StudentResultCard(
                          testResultEntity: state.testResultEntity),
                    ),
                    context: context);
              }
            },
            child: ScoreStatCard(
              label: LocaleKeys.highestScore,
              value: state is TestConsequencesGetHighestScorSuccess
                  ? state.testResultEntity.result.toString()
                  : "0",
              total: state is TestConsequencesGetHighestScorSuccess
                  ? state.testResultEntity.totalQuestions.toString()
                  : "0",
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }
}
