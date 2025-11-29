import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ScoreStatCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubscriberLowestScoreCard extends StatefulWidget {
  const SubscriberLowestScoreCard({super.key});

  @override
  State<SubscriberLowestScoreCard> createState() =>
      _SubscriberLowestScoreCardState();
}

class _SubscriberLowestScoreCardState extends State<SubscriberLowestScoreCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
      buildWhen: (previous, current) {
        if (current is GetSubscriberLowestScoreFailure ||
            current is GetSubscriberLowestScoreLoading ||
            current is GetSubscriberLowestScoreSuccess) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is GetSubscriberLowestScoreFailure) {
          return Expanded(
            child: Text(
              state.errmessage,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles(context).regular14.copyWith(color: Colors.red),
            ),
          );
        }
        return Skeletonizer(
          enabled: state is GetSubscriberLowestScoreLoading,
          child: InkWell(
            onTap: () {
              if (state is GetSubscriberLowestScoreSuccess) {
                showCustomModalBottomSheet(
                    child: IntrinsicHeight(
                      child: StudentResultCard(testResultEntity: state.result),
                    ),
                    context: context);
              }
            },
            child: ScoreStatCard(
              label: LocaleKeys.lowestScore,
              value: state is GetSubscriberLowestScoreSuccess
                  ? state.result.result.toString()
                  : "0",
              total: state is GetSubscriberLowestScoreSuccess
                  ? state.result.totalQuestions.toString()
                  : "0",
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }
}
