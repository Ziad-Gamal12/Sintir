import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsSheetHeader extends StatelessWidget {
  const TransactionDetailsSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          LocaleKeys.transactionDetailsTitle,
          style: textStyles.bold16.copyWith(
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: theme.dividerTheme.color!),
              ),
              child: Icon(
                Icons.close,
                size: 18,
                color: theme.iconTheme.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
