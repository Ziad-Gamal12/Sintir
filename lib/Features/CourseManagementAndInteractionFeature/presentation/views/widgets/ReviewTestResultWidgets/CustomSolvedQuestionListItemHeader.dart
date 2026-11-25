import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

/// Question number and correct/wrong status, side by side when they fit and
/// on two lines when they don't.
class CustomSolvedQuestionListItemHeader extends StatelessWidget {
  const CustomSolvedQuestionListItemHeader({
    super.key,
    required this.index,
    required this.length,
    required this.isCorrect,
  });

  final int index;
  final int length;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusBgColor =
        isCorrect ? Colors.green.shade400 : Colors.red.shade400;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _HeaderPill(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Text(
            "${LocaleKeys.questionNumber} ${index + 1}/$length",
            style: AppTextStyles(context)
                .semiBold14
                .copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        _HeaderPill(
          color: statusBgColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCorrect ? Icons.check_rounded : Icons.close_rounded,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  isCorrect ? LocaleKeys.correctAnswer : LocaleKeys.wrongAnswer,
                  style: AppTextStyles(
                    context,
                  ).semiBold14.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderPill extends StatelessWidget {
  const _HeaderPill({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
