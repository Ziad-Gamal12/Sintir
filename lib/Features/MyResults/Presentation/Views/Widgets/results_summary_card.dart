import 'package:flutter/material.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_status_mapper.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_average_gauge.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_summary_text.dart';

class ResultsSummaryCard extends StatelessWidget {
  const ResultsSummaryCard({
    super.key,
    required this.average,
    required this.count,
    this.passedCount,
  });
  final int average;
  final int count;
  final int? passedCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = ResultsTokens.of(theme);
    final status = ResultsStatusMapper.average(average.toDouble(), theme);
    return DecoratedBox(
      decoration: tokens.cardDecoration(theme),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ResultsAverageGauge(value: average, color: status.color),
            const SizedBox(width: 16),
            Expanded(
              child: ResultsSummaryText(
                status: status,
                tokens: tokens,
                count: count,
                passedCount: passedCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
