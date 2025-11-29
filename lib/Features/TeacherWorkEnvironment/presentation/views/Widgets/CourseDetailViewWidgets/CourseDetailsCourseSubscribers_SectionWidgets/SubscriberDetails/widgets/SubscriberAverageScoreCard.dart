import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberAverageScoreCard extends StatefulWidget {
  const SubscriberAverageScoreCard({super.key});

  @override
  State<SubscriberAverageScoreCard> createState() =>
      _SubscriberAverageScoreCardState();
}

class _SubscriberAverageScoreCardState
    extends State<SubscriberAverageScoreCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
      buildWhen: (previous, current) {
        if (current is SubscriberAvrageCalculationSuccess) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        double average =
            state is SubscriberAvrageCalculationSuccess ? state.avrage : 0;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                average.toStringAsFixed(2),
                style:
                    AppTextStyles(context).bold24.copyWith(color: KMainColor),
              ),
              const SizedBox(height: 10),
              Text(
                LocaleKeys.averageResults,
                textAlign: TextAlign.center,
                style: AppTextStyles(context).bold16,
              ),
            ],
          ),
        );
      },
    );
  }
}
