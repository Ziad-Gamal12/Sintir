import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TeacherWalletBalanceDetailsRow extends StatelessWidget {
  final FaIconData icon;
  final String title;
  final String value;

  const TeacherWalletBalanceDetailsRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        FaIcon(icon, color: theme.iconTheme.color, size: 20),
        const SizedBox(width: 10),
        Text(title,
            style: AppTextStyles(context)
                .regular16
                .copyWith(color: theme.textTheme.bodyMedium?.color)),
        const Spacer(),
        Text(value,
            style: AppTextStyles(context)
                .semiBold16
                .copyWith(color: theme.textTheme.bodyMedium?.color)),
      ],
    );
  }
}
