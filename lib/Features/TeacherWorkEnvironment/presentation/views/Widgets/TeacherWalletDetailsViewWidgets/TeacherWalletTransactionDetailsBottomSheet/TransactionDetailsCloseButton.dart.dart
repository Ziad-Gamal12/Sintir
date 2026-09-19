import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsCloseButton extends StatelessWidget {
  const TransactionDetailsCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => GoRouter.of(context).pop(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(color: theme.dividerTheme.color!),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          LocaleKeys.closeButtonLabel,
          style: textStyles.semiBold14.copyWith(
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
