import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/AverageScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ScoreStatCard.dart';

class ResultsAnalysisCard extends StatelessWidget {
  const ResultsAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Text("تحليل النتائج", style: AppTextStyles(context).bold24),
          const SizedBox(height: 20),
          const AverageScoreCard(),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ScoreStatCard(
                label: "أعلى درجة",
                value: "20",
                total: "25",
                color: Colors.green,
              ),
              ScoreStatCard(
                label: "أقل درجة",
                value: "15",
                total: "25",
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
