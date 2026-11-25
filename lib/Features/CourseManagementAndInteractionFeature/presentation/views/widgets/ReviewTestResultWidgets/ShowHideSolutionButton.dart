import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class ShowHideSolutionButton extends StatelessWidget {
  const ShowHideSolutionButton({
    super.key,
    required this.isVisible,
    required this.onTap,
  });

  final bool isVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor.withValues(alpha: 0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: theme.primaryColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          // Keeps a comfortable touch target.
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isVisible
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: theme.primaryColor,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    isVisible
                        ? LocaleKeys.hideSolution
                        : LocaleKeys.showSolution,
                    style: AppTextStyles(
                      context,
                    ).semiBold14.copyWith(color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
