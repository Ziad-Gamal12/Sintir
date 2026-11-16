import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class TonalViewResultButton extends StatelessWidget {
  const TonalViewResultButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = ResultsTokens.of(theme);
    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.visibility_rounded, size: 18),
        label: Text(
          LocaleKeys.viewResult,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 44),
          foregroundColor: theme.colorScheme.onSurface,
          backgroundColor: tokens.inner,
          side: BorderSide(color: tokens.border),
          textStyle: AppTextStyles(context).medium12,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
