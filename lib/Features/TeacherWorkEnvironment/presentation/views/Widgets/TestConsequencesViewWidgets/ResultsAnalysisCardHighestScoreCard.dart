import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentScoreSpotlightCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';

class ResultsAnalysisCardHighestScoreCard extends StatelessWidget {
  const ResultsAnalysisCardHighestScoreCard({super.key, this.onRetry});

  final VoidCallback? onRetry;

  static const Color _accent = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) =>
          current is TestConsequencesGetHighestScorFailure ||
          current is TestConsequencesGetHighestScorLoading ||
          current is TestConsequencesGetHighestScorSuccess,
      builder: (context, state) {
        if (state is TestConsequencesGetHighestScorFailure) {
          return ScoreSpotlightErrorCard(
            title: LocaleKeys.highestScore,
            message: state.errMessage,
            onRetry: onRetry,
          );
        }

        return StudentScoreSpotlightCard(
          title: LocaleKeys.highestScore,
          badgeIcon: LucideIcons.trophy,
          accentColor: _accent,
          isLoading: state is TestConsequencesGetHighestScorLoading,
          resultEntity: state is TestConsequencesGetHighestScorSuccess
              ? state.testResultEntity
              : null,
        );
      },
    );
  }
}
