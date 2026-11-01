import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsEmpty extends StatelessWidget {
  const ResultsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.inbox_outlined,
              size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(LocaleKeys.resultsEmptyTitle,
              style: style.semiBold16
                  .copyWith(color: theme.colorScheme.onSurface)),
          const SizedBox(height: 4),
          Text(LocaleKeys.resultsEmptyHint,
              textAlign: TextAlign.center,
              style: style.regular14
                  .copyWith(color: ResultsTokens.of(theme).muted)),
        ]),
      ),
    );
  }
}
