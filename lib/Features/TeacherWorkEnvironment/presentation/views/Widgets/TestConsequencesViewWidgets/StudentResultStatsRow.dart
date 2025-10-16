import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentStatItem.dart';

class StudentResultStatsRow extends StatelessWidget {
  const StudentResultStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsGraphBar,
            value: "75%",
            title: "نسبة التقييم",
            backgroundColor: Colors.lightBlue.shade100,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 1,
              height: 50,
              color: Colors.grey.shade300,
            )),
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsMisionIcon,
            value: "15/20",
            title: "درجة الطالب",
            backgroundColor: Colors.lightBlue.shade100,
          ),
        ),
      ],
    );
  }
}
