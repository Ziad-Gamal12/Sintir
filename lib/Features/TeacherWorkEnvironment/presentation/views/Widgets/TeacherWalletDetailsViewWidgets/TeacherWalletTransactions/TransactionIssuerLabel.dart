import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TransactionIssuerLabel extends StatelessWidget {
  const TransactionIssuerLabel({
    super.key,
    required this.issuer,
    required this.issuerColor,
  });

  final String issuer;
  final Color issuerColor;

  @override
  Widget build(BuildContext context) {
    final textStyles = AppTextStyles(context);
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: issuerColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          issuer,
          style: textStyles.regular12.copyWith(
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}
