import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestStatsInfoAttendedStudentCount extends StatefulWidget {
  const TestStatsInfoAttendedStudentCount({super.key});

  @override
  State<TestStatsInfoAttendedStudentCount> createState() =>
      _TestStatsInfoAttendedStudentCountState();
}

class _TestStatsInfoAttendedStudentCountState
    extends State<TestStatsInfoAttendedStudentCount> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) {
        return current is TestConsequencesGetAttendedCountSuccess ||
            current is TestConsequencesGetAttendedCountLoading ||
            current is TestConsequencesGetAttendedCountFailure;
      },
      builder: (context, state) {
        if (state is TestConsequencesGetAttendedCountFailure) {
          return Expanded(
              child: Text(
            state.errMessage,
            style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
          ));
        }
        return Expanded(
            child: Skeletonizer(
          enabled: state is TestConsequencesGetAttendedCountLoading,
          child: _buildStatColumn(
              LocaleKeys.studentsAttended,
              state is TestConsequencesGetAttendedCountSuccess
                  ? state.count.toString()
                  : "0",
              context),
        ));
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
