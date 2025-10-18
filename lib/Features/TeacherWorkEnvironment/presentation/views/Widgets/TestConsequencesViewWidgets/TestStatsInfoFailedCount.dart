import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestStatsInfoFailedCount extends StatefulWidget {
  const TestStatsInfoFailedCount({super.key});

  @override
  State<TestStatsInfoFailedCount> createState() =>
      _TestStatsInfoFailedCountState();
}

class _TestStatsInfoFailedCountState extends State<TestStatsInfoFailedCount> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) {
        return current is TestConsequencesGetFailedCountSuccess ||
            current is TestConsequencesGetFailedCountLoading ||
            current is TestConsequencesGetFailedCountFailure;
      },
      builder: (context, state) {
        if (state is TestConsequencesGetFailedCountFailure) {
          return Expanded(
            child: Text(
              state.errMessage,
              style:
                  AppTextStyles(context).regular14.copyWith(color: Colors.red),
            ),
          );
        }
        return Expanded(
          child: Skeletonizer(
            enabled: state is TestConsequencesGetFailedCountLoading,
            child: _buildStatColumn(
                "عدد الطلاب الرسوب:",
                state is TestConsequencesGetFailedCountSuccess
                    ? state.count.toString()
                    : "0",
                context,
                color: Colors.red),
          ),
        );
      },
    );
  }

  Widget _buildStatColumn(String label, String value, BuildContext context,
      {Color color = Colors.black}) {
    return Column(
      children: [
        Text(label,
            style: AppTextStyles(context)
                .semiBold14
                .copyWith(color: Colors.black)),
        const SizedBox(height: 10),
        Text(value,
            style: AppTextStyles(context).bold14.copyWith(color: color)),
      ],
    );
  }
}
