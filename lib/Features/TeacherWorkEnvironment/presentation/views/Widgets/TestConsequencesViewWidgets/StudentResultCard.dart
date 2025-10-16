import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentInfoTexts.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatsRow.dart';
import 'package:sintir/constant.dart';

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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StudentAvatar(),
              const SizedBox(width: 20),
              const StudentInfoTexts(),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.visibility, color: KMainColor),
                  const SizedBox(width: 5),
                  Text(
                    "عرض النتيجة",
                    style: AppTextStyles(context)
                        .regular16
                        .copyWith(color: KMainColor),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          const StudentResultStatsRow(),
        ],
      ),
    );
  }
}
