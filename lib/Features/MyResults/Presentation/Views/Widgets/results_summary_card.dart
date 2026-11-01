import 'package:flutter/material.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_average_gauge.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_count_tile.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_status_mapper.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_summary_text.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_tokens.dart';

class ResultsSummaryCard extends StatelessWidget {
  const ResultsSummaryCard(
      {super.key, required this.average, required this.count});
  final int average;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = ResultsTokens.of(theme);
    final status = ResultsStatusMapper.average(average.toDouble(), theme);
    final gradient = theme.brightness == Brightness.dark
        ? LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
                tokens.card,
                theme.colorScheme.secondary.withValues(alpha: .08)
              ])
        : null;
    return DecoratedBox(
      decoration: tokens.cardDecoration(theme, gradient: gradient),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: LayoutBuilder(builder: (context, constraints) {
          final stacked = constraints.maxWidth < 320 ||
              MediaQuery.textScalerOf(context).scale(1) > 1.3;
          final countTile = ResultsCountTile(count: count, tokens: tokens);
          if (stacked) {
            return Column(children: [
              Row(children: [
                ResultsAverageGauge(value: average, color: status.color),
                const SizedBox(width: 16),
                Expanded(
                    child: ResultsSummaryText(status: status, tokens: tokens)),
              ]),
              const SizedBox(height: 12),
              Align(alignment: AlignmentDirectional.center, child: countTile),
            ]);
          }
          return Row(children: [
            ResultsAverageGauge(value: average, color: status.color),
            const SizedBox(width: 16),
            Expanded(child: ResultsSummaryText(status: status, tokens: tokens)),
            const SizedBox(width: 12),
            countTile,
          ]);
        }),
      ),
    );
  }
}
