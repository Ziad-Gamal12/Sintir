import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsFooterNote extends StatelessWidget {
  const ResultsFooterNote({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final tokens = ResultsTokens.of(theme);
    return DecoratedBox(
      decoration: tokens.cardDecoration(theme),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(16),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colorScheme.secondary)),
              child: Icon(Icons.info_outline_rounded,
                  size: 18, color: theme.colorScheme.secondary)),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(LocaleKeys.resultsFooterNote,
                    style: style.regular12.copyWith(color: tokens.muted)),
                const SizedBox(height: 10),
                Text(LocaleKeys.resultsBrandLine,
                    textAlign: TextAlign.end,
                    style: style.semiBold10.copyWith(color: tokens.muted)),
              ])),
        ]),
      ),
    );
  }
}
