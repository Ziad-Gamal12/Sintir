import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.leading,
    this.forceLtr = false,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final Widget? leading;
  final bool forceLtr;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);

    Widget valueWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            value,
            style: textStyles.semiBold13.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
        if (leading != null) ...[
          const SizedBox(width: 4),
          leading!,
        ],
      ],
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: textStyles.regular13.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: valueWidget,
              ),
            ],
          ),
        ),
        if (showDivider) Divider(height: 1, color: theme.dividerTheme.color),
      ],
    );
  }
}
