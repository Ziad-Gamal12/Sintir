import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_status_mapper.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsSummaryText extends StatelessWidget {
  const ResultsSummaryText(
      {super.key, required this.status, required this.tokens});
  final ResultsStatus status;
  final ResultsTokens tokens;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(LocaleKeys.resultsGeneralAverage,
          style: style.semiBold16.copyWith(color: theme.colorScheme.onSurface)),
      const SizedBox(height: 3),
      Text(LocaleKeys.resultsAverageSubtitle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: style.regular12.copyWith(color: tokens.muted)),
      const SizedBox(height: 8),
      Row(children: [
        Container(
            width: 7,
            height: 7,
            decoration:
                BoxDecoration(color: status.color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Expanded(
            child: Text(status.label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: style.medium12.copyWith(color: status.color))),
      ]),
    ]);
  }
}
