import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentInfoTexts.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCardDisplayFullResultWIdget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatsRow.dart';

class StudentResultCard extends StatelessWidget {
  const StudentResultCard({super.key, required this.testResultEntity});
  final TestResultEntity testResultEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 30,
            spreadRadius: 1,
            offset: const Offset(5, 15),
          )
        ],
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StudentAvatar(
                url: testResultEntity.joinedbyentity.imageUrl,
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: StudentInfoTexts(
                  testResult: testResultEntity,
                ),
              ),
              const Spacer(),
              StudentResultCardDisplayFullResultWIdget(
                testResultEntity: testResultEntity,
              )
            ],
          ),
          const Spacer(),
          StudentResultStatsRow(
            testResultEntity: testResultEntity,
          ),
        ],
      ),
    );
  }
}
