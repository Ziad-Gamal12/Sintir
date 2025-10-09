import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TeacherWalletBalanceDetailsRow extends StatelessWidget {
  final IconData icon;
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
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 20),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(color: Colors.black)),
        const Spacer(),
        Text(value, style: AppTextStyles(context).semiBold16),
      ],
    );
  }
}
