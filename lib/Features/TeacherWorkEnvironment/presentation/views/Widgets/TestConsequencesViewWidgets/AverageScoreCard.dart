import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';
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
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color borderColor = theme.dividerColor;
    final Color primaryColor = theme.colorScheme.primary;
    final Color errorColor = theme.colorScheme.error;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;

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
          return Expanded(
            child: Text(
              state.errMessage,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles(context).regular14.copyWith(color: errorColor),
            ),
          );
        } else if (state is TestConsequencesGetHighestScorFailure) {
          return Expanded(
            child: Text(
              state.errMessage,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles(context).regular14.copyWith(color: errorColor),
            ),
          );
        }
        return Skeletonizer(
          enabled: state is TestConsequencesGetHighestScorLoading ||
              state is TestConsequencesGetLowestScorLoading,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  "${(highestScore + lowestScore) / 2}",
                  style: AppTextStyles(context)
                      .bold24
                      .copyWith(color: primaryColor),
                ),
                const SizedBox(height: 10),
                Text(
                  LocaleKeys.averageResults,
                  style: AppTextStyles(context)
                      .bold16
                      .copyWith(color: primaryTextColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
