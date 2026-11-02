import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsError extends StatelessWidget {
  const ResultsError({super.key, required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.cloud_off_rounded,
              size: 44, color: ResultsTokens.of(theme).failure),
          const SizedBox(height: 12),
          Text(LocaleKeys.resultsErrorTitle,
              style: style.semiBold16
                  .copyWith(color: theme.colorScheme.onSurface)),
          const SizedBox(height: 12),
          OutlinedButton(
              onPressed: onRetry, child: Text(LocaleKeys.resultsRetry)),
        ]),
      ),
    );
  }
}
