import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/assessment_status_chip.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_date_formatter.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_status_mapper.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsSummaryText extends StatelessWidget {
  const ResultsSummaryText({
    super.key,
    required this.status,
    required this.tokens,
    required this.count,
    this.passedCount,
  });
  final ResultsStatus status;
  final ResultsTokens tokens;
  final int count;
  final int? passedCount;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final stats = [
      LocaleKeys.resultsRecordedCountValue(count, lang),
      if (passedCount != null)
        '${ResultsDateFormatter.number(context, passedCount!)}/'
            '${ResultsDateFormatter.number(context, count)} ${LocaleKeys.passed}',
    ].join('  •  ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.resultsGeneralAverage,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: style.semiBold16.copyWith(color: theme.colorScheme.onSurface),
        ),
        const SizedBox(height: 8),
        AssessmentStatusChip(status: status),
        const SizedBox(height: 8),
        Text(
          stats,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: style.regular13.copyWith(color: tokens.muted),
        ),
      ],
    );
  }
}
