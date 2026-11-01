import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsEndOfList extends StatelessWidget {
  const ResultsEndOfList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final muted = ResultsTokens.of(theme).muted;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.check_circle_outline_rounded, size: 16, color: muted),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            LocaleKeys.resultsAllLoaded,
            textAlign: TextAlign.center,
            style: style.regular12.copyWith(color: muted),
          ),
        ),
      ]),
    );
  }
}
