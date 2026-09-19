import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TeachersTransactionsListViewHeader extends StatelessWidget {
  const TeachersTransactionsListViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(LocaleKeys.recentTransactionsTitle,
            style: AppTextStyles(context)
                .bold16
                .copyWith(color: theme.textTheme.bodyMedium?.color)),
      ],
    );
  }
}
