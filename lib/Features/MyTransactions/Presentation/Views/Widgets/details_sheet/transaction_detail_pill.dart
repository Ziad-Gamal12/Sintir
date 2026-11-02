import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TransactionDetailPill extends StatelessWidget {
  const TransactionDetailPill({
    super.key,
    required this.label,
    required this.color,
    required this.surface,
    required this.icon,
  });

  final String label;
  final Color color;
  final Color surface;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTextStyles(context).regular11.copyWith(color: color),
        ),
      ],
    ),
  );
}
