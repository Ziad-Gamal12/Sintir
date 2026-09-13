import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TeachersTransactionsListViewHeader extends StatelessWidget {
  const TeachersTransactionsListViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("آخر المعاملات",
            style: AppTextStyles(context)
                .bold16
                .copyWith(color: theme.textTheme.bodyMedium?.color)),
        Text("عرض الكل",
            style: AppTextStyles(context)
                .semiBold12
                .copyWith(color: theme.colorScheme.primary))
      ],
    );
  }
}
