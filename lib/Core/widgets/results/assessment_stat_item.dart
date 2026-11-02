import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';

class AssessmentStatItem extends StatelessWidget {
  const AssessmentStatItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, size: 16, color: ResultsTokens.of(theme).muted),
        const SizedBox(width: 5),
        Expanded(
            child: Text(label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: style.regular12
                    .copyWith(color: ResultsTokens.of(theme).muted))),
      ]),
      const SizedBox(height: 4),
      Text(value,
          style: style.medium12.copyWith(color: theme.colorScheme.onSurface)),
    ]);
  }
}
