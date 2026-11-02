import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_detail_copy_button.dart';

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.copy = false,
    this.ltr = false,
    this.valueColor,
    this.grouped = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool copy;
  final bool ltr;
  final Color? valueColor;
  final bool grouped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: grouped
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsetsDirectional.fromSTEB(
        10,
        grouped ? 9 : 10,
        8,
        grouped ? 9 : 10,
      ),
      decoration: BoxDecoration(
        color: grouped ? Colors.transparent : theme.cardColor,
        borderRadius: BorderRadius.circular(grouped ? 0 : 10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final labelText = Text(
            label,
            style: AppTextStyles(
              context,
            ).regular11.copyWith(color: theme.colorScheme.onSurfaceVariant),
          );
          final valueText = Directionality(
            textDirection: ltr ? TextDirection.ltr : Directionality.of(context),
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles(context).regular12.copyWith(
                color: valueColor ?? theme.colorScheme.onSurface,
                fontFeatures: ltr ? const [FontFeature.tabularFigures()] : null,
              ),
            ),
          );
          final copyButton = copy
              ? TransactionDetailCopyButton(value: value)
              : null;
          if (constraints.maxWidth < 360) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 18,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: labelText),
                    ?copyButton,
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 26),
                  child: valueText,
                ),
              ],
            );
          }
          return Row(
            children: [
              Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Expanded(flex: 4, child: labelText),
              const SizedBox(width: 8),
              Expanded(flex: 6, child: valueText),
              ?copyButton,
            ],
          );
        },
      ),
    );
  }
}
