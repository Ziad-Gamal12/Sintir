import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_status_mapper.dart';

class AssessmentStatusChip extends StatelessWidget {
  const AssessmentStatusChip({super.key, required this.status});
  final ResultsStatus status;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(status.icon, size: 14, color: status.color),
            const SizedBox(width: 4),
            Text(
              status.label,
              style: style.regular12.copyWith(
                color: status.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
