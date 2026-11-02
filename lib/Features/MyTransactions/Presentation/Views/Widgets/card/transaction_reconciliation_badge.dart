import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/PaymentStatusPalette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TransactionReconciliationBadge extends StatelessWidget {
  const TransactionReconciliationBadge({super.key, required this.isMatched});
  final bool? isMatched;

  @override
  Widget build(BuildContext context) {
    final colors = PaymentStatusPalette.forTheme(Theme.of(context));
    final matched = isMatched == true;
    final color = matched ? colors.success : colors.information;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 3, 8, 3),
      decoration: BoxDecoration(
        color: matched ? colors.successSurface : colors.informationSurface,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(matched ? Icons.done_all : Icons.sync, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            matched
                ? LocaleKeys.transactionsMatched
                : LocaleKeys.transactionsUnmatched,
            style: AppTextStyles(context).regular10.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
