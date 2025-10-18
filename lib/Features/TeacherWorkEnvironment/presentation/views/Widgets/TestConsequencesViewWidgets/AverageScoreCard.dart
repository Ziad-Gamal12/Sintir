import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AverageScoreCard extends StatefulWidget {
  const AverageScoreCard({super.key});

  @override
  State<AverageScoreCard> createState() => _AverageScoreCardState();
}

class _AverageScoreCardState extends State<AverageScoreCard> {
  int highestScore = 0;
  int lowestScore = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestConsequencesCubit, TestConsequencesState>(
      listener: (context, state) {
        if (state is TestConsequencesGetHighestScorSuccess) {
          highestScore = state.testResultEntity.result;
        } else if (state is TestConsequencesGetLowestScorSuccess) {
          lowestScore = state.testResultEntity.result;
        }
      },
      builder: (context, state) {
        if (state is TestConsequencesGetLowestScorFailure) {
          return Text(
            state.errMessage,
            style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
          );
        } else if (state is TestConsequencesGetHighestScorFailure) {
          return Text(
            state.errMessage,
            style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
          );
        }
        return Skeletonizer(
          enabled: state is TestConsequencesGetHighestScorLoading ||
              state is TestConsequencesGetLowestScorLoading,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  "${(highestScore + lowestScore) / 2}",
                  style:
                      AppTextStyles(context).bold24.copyWith(color: KMainColor),
                ),
                const SizedBox(height: 10),
                Text(
                  "معدل النتائج",
                  style: AppTextStyles(context).bold16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
