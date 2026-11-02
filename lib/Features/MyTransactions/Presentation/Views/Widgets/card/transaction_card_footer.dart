import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_metadata.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/locale_keys.dart';

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
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                TransactionDisplayFormatters.shortId(transaction.transactionId),
                style: AppTextStyles(context).regular11.copyWith(
                  letterSpacing: .35,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              tooltip: LocaleKeys.transactionsCopy,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              onPressed: () => _copy(context),
              icon: const Icon(Icons.copy_outlined, size: 15),
            ),
          ],
        ),
        TransactionCardMetadata(transaction: transaction),
      ],
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: transaction.transactionId));
    await HapticFeedback.selectionClick();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.transactionsCopied),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
