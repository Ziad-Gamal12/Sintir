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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.85),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.primaryColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isVisible
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              color: theme.primaryColor,
              size: 22,
            ),
            const SizedBox(width: 6),
            Text(
              isVisible ? LocaleKeys.showSolution : LocaleKeys.hideSolution,
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: theme.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
