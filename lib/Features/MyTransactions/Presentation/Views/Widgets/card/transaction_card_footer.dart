import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCopyToClipboard.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_metadata.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';

class TransactionCardFooter extends StatelessWidget {
  const TransactionCardFooter({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 8,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              TransactionDisplayFormatters.shortId(transaction.transactionId),
              style: AppTextStyles(context).regular11.copyWith(
                letterSpacing: .35,
                fontFeatures: const [FontFeature.tabularFigures()],
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            CustomCopyToClipboard(value: transaction.transactionId),
          ],
        ),
        TransactionCardMetadata(transaction: transaction),
      ],
    );
  }
}
