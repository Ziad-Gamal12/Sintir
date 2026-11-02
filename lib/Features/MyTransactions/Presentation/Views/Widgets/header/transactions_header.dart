import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/summary/transaction_share_summary.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsHeader extends StatelessWidget {
  const TransactionsHeader({super.key, required this.transactions});

  final List<TransactionEntity> transactions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      LocaleKeys.transactionsTitle,
                      style: styles.semiBold20,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: TransactionsStyleMapper.primary(
                        theme,
                      ).withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      LocaleKeys.transactionsUpdated,
                      style: styles.regular10.copyWith(
                        color: TransactionsStyleMapper.primary(theme),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocaleKeys.transactionsSubtitle,
                  style: styles.regular12.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        IconButton.filledTonal(
          style: IconButton.styleFrom(
            foregroundColor: TransactionsStyleMapper.primary(theme),
            backgroundColor: TransactionsStyleMapper.primary(
              theme,
            ).withValues(alpha: .1),
            shape: const CircleBorder(),
            side: BorderSide(color: TransactionsStyleMapper.cardBorder(theme)),
          ),
          tooltip: LocaleKeys.transactionsShare,
          onPressed: transactions.isEmpty ? null : () => _share(context),
          icon: const Icon(Icons.ios_share_outlined),
        ),
      ],
    );
  }

  Future<void> _share(BuildContext context) async {
    final renderBox = context.findRenderObject() as RenderBox?;
    final origin = renderBox == null
        ? null
        : renderBox.localToGlobal(Offset.zero) & renderBox.size;
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: TransactionShareSummary.forTransactions(context, transactions),
          title: LocaleKeys.transactionsTitle,
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
