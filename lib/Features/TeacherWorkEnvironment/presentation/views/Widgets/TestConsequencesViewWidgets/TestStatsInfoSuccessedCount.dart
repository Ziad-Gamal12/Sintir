import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestStatsInfoSuccessedCount extends StatefulWidget {
  const TestStatsInfoSuccessedCount({super.key});

  @override
  State<TestStatsInfoSuccessedCount> createState() =>
      _TestStatsInfoSuccessedCountState();
}

class _TestStatsInfoSuccessedCountState
    extends State<TestStatsInfoSuccessedCount> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    const Color successColor = Colors.green;
    final Color errorColor = theme.colorScheme.error;

    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) {
        return current is TestConsequencesGetSuccessedCountSuccess ||
            current is TestConsequencesGetSuccessedCountLoading ||
            current is TestConsequencesGetSuccessedCountFailure;
      },
      builder: (context, state) {
        if (state is TestConsequencesGetSuccessedCountFailure) {
          return Expanded(
            child: Text(
              state.errMessage,
              style:
                  AppTextStyles(context).regular14.copyWith(color: errorColor),
            ),
          );
        }
        return Expanded(
          child: Skeletonizer(
            enabled: state is TestConsequencesGetSuccessedCountLoading,
            child: _buildStatColumn(
                LocaleKeys.studentsPassed,
                state is TestConsequencesGetSuccessedCountSuccess
                    ? state.count.toString()
                    : "0",
                context,
                color: successColor),
          ),
        );
      },
    );
  }

  Widget _buildStatColumn(String label, String value, BuildContext context,
      {Color color = Colors.black}) {
    final Color labelColor = Theme.of(context).textTheme.bodyLarge!.color!;

    return Column(
      children: [
        Text(label,
            style:
                AppTextStyles(context).semiBold14.copyWith(color: labelColor)),
        const SizedBox(height: 10),
        Text(value,
            style: AppTextStyles(context).bold14.copyWith(color: color)),
      ],
    );
  }
}
