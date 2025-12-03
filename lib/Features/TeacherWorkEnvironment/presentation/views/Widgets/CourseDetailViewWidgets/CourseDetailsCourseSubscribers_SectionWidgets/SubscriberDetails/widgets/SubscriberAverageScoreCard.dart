import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
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
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color borderColor = theme.dividerColor;
    final Color mainColor = theme.colorScheme.primary;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;

    return BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
      buildWhen: (previous, current) {
        // Only rebuild when the state is a successful calculation or if you need to show a loading/error state.
        // Based on the original logic, we only check for success.
        return current is SubscriberAvrageCalculationSuccess;
      },
      builder: (context, state) {
        // Default to 0 if calculation hasn't run or failed (though failure is not explicitly handled in original logic)
        double average =
            state is SubscriberAvrageCalculationSuccess ? state.avrage : 0;

        // Handle loading or initial states (where average is likely 0) by optionally showing a shimmer/skeleton or just 0
        // Since the original code doesn't explicitly check for loading, we proceed with the average value.

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor, // Use theme card color
            border: Border.all(
                color: borderColor), // Use theme divider color for border
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                average.toStringAsFixed(2),
                style: AppTextStyles(context).bold24.copyWith(
                      color: mainColor, // Use theme primary color for the score
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                LocaleKeys.averageResults,
                textAlign: TextAlign.center,
                style: AppTextStyles(context).bold16.copyWith(
                      color:
                          primaryTextColor, // Use theme body text color for the label
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
