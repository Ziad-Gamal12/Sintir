import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class AssessmentPassIndicator extends StatelessWidget {
  const AssessmentPassIndicator({super.key, required this.isPassed});
  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = ResultsTokens.of(theme);
    final color = isPassed ? tokens.success : tokens.failure;
    final label =
        isPassed ? LocaleKeys.resultsPassed : LocaleKeys.resultsNotPassed;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(isPassed ? Icons.check_circle_rounded : Icons.cancel_rounded,
          size: 18, color: color),
      const SizedBox(width: 6),
      Text(label,
          style: AppTextStyles(context).medium12.copyWith(color: color)),
    ]);
  }
}
