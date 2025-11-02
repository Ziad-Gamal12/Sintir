import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ScoreStatCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ResultsAnalysisCardLowestScoreCard extends StatefulWidget {
  const ResultsAnalysisCardLowestScoreCard({super.key});

  @override
  State<ResultsAnalysisCardLowestScoreCard> createState() =>
      _ResultsAnalysisCardLowestScoreCardState();
}

class _ResultsAnalysisCardLowestScoreCardState
    extends State<ResultsAnalysisCardLowestScoreCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) {
        if (current is TestConsequencesGetLowestScorFailure ||
            current is TestConsequencesGetLowestScorLoading ||
            current is TestConsequencesGetLowestScorSuccess) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is TestConsequencesGetLowestScorFailure) {
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
          enabled: state is TestConsequencesGetLowestScorLoading,
          child: InkWell(
            onTap: () {
              if (state is TestConsequencesGetLowestScorSuccess) {
                showCustomModalBottomSheet(
                    child: IntrinsicHeight(
                      child: StudentResultCard(
                          testResultEntity: state.testResultEntity),
                    ),
                    context: context);
              }
            },
            child: ScoreStatCard(
              label: "أقل درجة",
              value: state is TestConsequencesGetLowestScorSuccess
                  ? state.testResultEntity.result.toString()
                  : "0",
              total: state is TestConsequencesGetLowestScorSuccess
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
