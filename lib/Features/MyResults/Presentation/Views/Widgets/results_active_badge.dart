import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsActiveBadge extends StatelessWidget {
  const ResultsActiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final success = ResultsTokens.of(theme).success;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 140),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 7,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: success.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: success, shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                LocaleKeys.statusActive,
                style: style.medium12.copyWith(color: success),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
