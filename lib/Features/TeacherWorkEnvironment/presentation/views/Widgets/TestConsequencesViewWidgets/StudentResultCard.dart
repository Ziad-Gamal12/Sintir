import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentInfoTexts.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatsRow.dart';

class StudentResultCard extends StatelessWidget {
  const StudentResultCard({super.key});

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
      child: const Column(
        children: [
          StudentAvatar(),
          SizedBox(height: 20),
          StudentInfoTexts(),
          SizedBox(height: 10),
          StudentResultStatsRow(),
        ],
      ),
    );
  }
}
