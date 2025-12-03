import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestAttendancePresentage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestStatsInfoAttendedStudentCount.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestStatsInfoFailedCount.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestStatsInfoSuccessedCount.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';

class TestStatsInfo extends StatefulWidget {
  const TestStatsInfo({super.key, required this.requirements});
  final TestConsequencesViewRequirements requirements;

  @override
  State<TestStatsInfo> createState() => _TestStatsInfoState();
}

class _TestStatsInfoState extends State<TestStatsInfo> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<TestConsequencesCubit>();
    cubit.getSuccessedStudentsCount(
        courseId: widget.requirements.courseID,
        sectionId: widget.requirements.sectionID,
        testId: widget.requirements.test.id);
    cubit.getFailedStudentsCount(
        courseId: widget.requirements.courseID,
        sectionId: widget.requirements.sectionID,
        testId: widget.requirements.test.id);
    cubit.getAttendedCount(
        courseId: widget.requirements.courseID,
        sectionId: widget.requirements.sectionID,
        testId: widget.requirements.test.id);
    cubit.getTotalStudentsCount(courseId: widget.requirements.courseID);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TestStatsInfoAttendedStudentCount(),
            verticalDivider(context),
            const Expanded(
              child: TestAttendancePresentage(),
            ),
          ],
        ),
        horizontalDivider(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TestStatsInfoSuccessedCount(),
            verticalDivider(context),
            const TestStatsInfoFailedCount(),
          ],
        ),
      ],
    );
  }

  Widget verticalDivider(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 1,
        color: Theme.of(context).dividerColor,
      );

  Widget horizontalDivider(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 1,
        color: Theme.of(context).dividerColor,
      );
}
