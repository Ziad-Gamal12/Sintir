import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsTimelineHeader extends StatelessWidget {
  const ResultsTimelineHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final muted = ResultsTokens.of(theme).muted;
    return Row(
      children: [
        Icon(Icons.history_rounded, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            LocaleKeys.resultsTimelineTitle,
            style: style.semiBold16.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        Flexible(
          child: Text(
            LocaleKeys.resultsAcademicTerm,
            textAlign: TextAlign.end,
            style: style.regular12.copyWith(color: muted),
          ),
        ),
      ],
    );
  }
}
