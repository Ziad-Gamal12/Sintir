import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/summary/transaction_share_summary.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsActions extends StatelessWidget {
  const TransactionDetailsActions({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton.icon(
      onPressed: () => _share(context),
      icon: const Icon(Icons.share_outlined),
      label: Text(LocaleKeys.transactionsShare),
    ),
  );

  Future<void> _share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: TransactionShareSummary.forTransaction(context, transaction),
          title: LocaleKeys.transactionsShare,
          subject: LocaleKeys.transactionsShare,
          sharePositionOrigin: origin,
        ),
      );
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.transactionsShareFailed)),
        );
      }
    }
  }
}
