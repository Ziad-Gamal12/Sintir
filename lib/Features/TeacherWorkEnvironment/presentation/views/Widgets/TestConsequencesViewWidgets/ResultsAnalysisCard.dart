import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/AverageScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultsAnalysisCardHighestScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultsAnalysisCardLowestScoreCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';

class ResultsAnalysisCard extends StatefulWidget {
  const ResultsAnalysisCard({
    super.key,
    required this.requirements,
    this.averageScore,
  });
  final TestConsequencesViewRequirements requirements;
  final double? averageScore;
  @override
  State<ResultsAnalysisCard> createState() => _ResultsAnalysisCardState();
}

class _ResultsAnalysisCardState extends State<ResultsAnalysisCard> {
  @override
  void initState() {
    super.initState();
    _loadHighest();
    _loadLowest();
  }

  void _loadHighest() {
    context.read<TestConsequencesCubit>().getHighestScore(
      courseId: widget.requirements.courseID,
      sectionId: widget.requirements.sectionID,
      testId: widget.requirements.test.id,
    );
  }

  void _loadLowest() {
    context.read<TestConsequencesCubit>().getLowestScore(
      courseId: widget.requirements.courseID,
      sectionId: widget.requirements.sectionID,
      testId: widget.requirements.test.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.resultsAnalysis,
          style: AppTextStyles(
            context,
          ).bold18.copyWith(color: theme.colorScheme.onSurface),
        ),
        const SizedBox(height: 16),

        AverageScoreCard(average: widget.averageScore),
        const SizedBox(height: 10),

        ResultsAnalysisCardHighestScoreCard(onRetry: _loadHighest),
        const SizedBox(height: 10),
        ResultsAnalysisCardLowestScoreCard(onRetry: _loadLowest),
      ],
    );
  }
}
