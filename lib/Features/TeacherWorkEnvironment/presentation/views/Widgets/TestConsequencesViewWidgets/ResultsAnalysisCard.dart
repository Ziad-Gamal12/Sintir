import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/AverageScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultsAnalysisCardHighestScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultsAnalysisCardLowestScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';

class ResultsAnalysisCard extends StatefulWidget {
  const ResultsAnalysisCard({super.key, required this.requirements});
  final TestConsequencesViewRequirements requirements;

  @override
  State<ResultsAnalysisCard> createState() => _ResultsAnalysisCardState();
}

class _ResultsAnalysisCardState extends State<ResultsAnalysisCard> {
  @override
  void initState() {
    super.initState();
    context.read<TestConsequencesCubit>().getHighestScore(
        courseId: widget.requirements.courseID,
        sectionId: widget.requirements.sectionID,
        testId: widget.requirements.test.id);
    context.read<TestConsequencesCubit>().getLowestScore(
        courseId: widget.requirements.courseID,
        sectionId: widget.requirements.sectionID,
        testId: widget.requirements.test.id);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Text(LocaleKeys.resultsAnalysis,
              style: AppTextStyles(context).bold24),
          const SizedBox(height: 20),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ResultsAnalysisCardHighestScoreCard(),
                SizedBox(width: 10),
                AverageScoreCard(),
                SizedBox(width: 10),
                ResultsAnalysisCardLowestScoreCard()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
