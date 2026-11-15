import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class StudentResultStatusChip extends StatelessWidget {
  const StudentResultStatusChip({
    super.key,
    required this.isPassed,
    required this.color,
  });

  final bool isPassed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPassed ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            isPassed ? LocaleKeys.passed : LocaleKeys.failed,
            style: style.semiBold14.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
