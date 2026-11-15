import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentScoreSpotlightCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';

class ResultsAnalysisCardLowestScoreCard extends StatelessWidget {
  const ResultsAnalysisCardLowestScoreCard({super.key, this.onRetry});

  final VoidCallback? onRetry;

  static const Color _accent = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestConsequencesCubit, TestConsequencesState>(
      buildWhen: (previous, current) =>
          current is TestConsequencesGetLowestScorFailure ||
          current is TestConsequencesGetLowestScorLoading ||
          current is TestConsequencesGetLowestScorSuccess,
      builder: (context, state) {
        if (state is TestConsequencesGetLowestScorFailure) {
          return ScoreSpotlightErrorCard(
            title: LocaleKeys.lowestScore,
            message: state.errMessage,
            onRetry: onRetry,
          );
        }

        return StudentScoreSpotlightCard(
          title: LocaleKeys.lowestScore,
          badgeIcon: LucideIcons.trendingDown,
          accentColor: _accent,
          isLoading: state is TestConsequencesGetLowestScorLoading,
          resultEntity: state is TestConsequencesGetLowestScorSuccess
              ? state.testResultEntity
              : null,
        );
      },
    );
  }
}
