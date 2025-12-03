import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestAttendancePresentage extends StatefulWidget {
  const TestAttendancePresentage({
    super.key,
  });

  @override
  State<TestAttendancePresentage> createState() =>
      _TestAttendancePresentageState();
}

class _TestAttendancePresentageState extends State<TestAttendancePresentage> {
  int attendedCount = 0;
  int totalStudents = 0;
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color backgroundColor =
        Theme.of(context).dividerColor.withOpacity(0.5);

    return BlocConsumer<TestConsequencesCubit, TestConsequencesState>(
      listenWhen: (previous, current) {
        if (current is TestConsequencesGetAttendedCountFailure ||
            current is TestConsequencesGetAttendedCountLoading ||
            current is TestConsequencesGetAttendedCountSuccess ||
            current is TestConsequencesGetTotalStudentsCountFailure ||
            current is TestConsequencesGetTotalStudentsCountLoading ||
            current is TestConsequencesGetTotalStudentsCountSuccess) {
          return true;
        } else {
          return false;
        }
      },
      buildWhen: (previous, current) {
        if (current is TestConsequencesGetAttendedCountFailure ||
            current is TestConsequencesGetAttendedCountLoading ||
            current is TestConsequencesGetAttendedCountSuccess ||
            current is TestConsequencesGetTotalStudentsCountFailure ||
            current is TestConsequencesGetTotalStudentsCountLoading ||
            current is TestConsequencesGetTotalStudentsCountSuccess) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state is TestConsequencesGetAttendedCountSuccess) {
          attendedCount = state.count;
        } else if (state is TestConsequencesGetTotalStudentsCountSuccess) {
          totalStudents = state.count;
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is TestConsequencesGetAttendedCountLoading ||
              state is TestConsequencesGetTotalStudentsCountLoading,
          child: CircularPercentIndicator(
            radius: 40,
            lineWidth: 10,
            animation: true,
            percent: totalStudents == 0 ? 0 : attendedCount / totalStudents,
            center: Text(
              totalStudents == 0
                  ? "0%"
                  : " ${(attendedCount / totalStudents * 100).toInt()}%",
              style:
                  AppTextStyles(context).semiBold16.copyWith(color: textColor),
            ),
            progressColor: primaryColor,
            backgroundColor: backgroundColor,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        );
      },
    );
  }
}
