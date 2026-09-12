import 'package:flutter/material.dart';

class TeacherWalletCardIcon extends StatelessWidget {
  const TeacherWalletCardIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
            width: 1.5),
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.account_balance_wallet_outlined,
        color: theme.colorScheme.primary,
        size: 20,
      ),
    );
  }
}
