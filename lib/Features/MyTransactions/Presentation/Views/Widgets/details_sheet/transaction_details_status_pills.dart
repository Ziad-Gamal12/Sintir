import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_detail_pill.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsStatusPills extends StatelessWidget {
  const TransactionDetailsStatusPills({
    super.key,
    required this.status,
    required this.reconciled,
  });
  final TransactionsStatus? status;
  final bool? reconciled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = TransactionsStyleMapper.statusColor(theme, status);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        TransactionDetailPill(
          label: switch (status) {
            TransactionsStatus.success => LocaleKeys.transactionsSuccess,
            TransactionsStatus.pending => LocaleKeys.transactionsPending,
            TransactionsStatus.failure => LocaleKeys.transactionsFailed,
            _ => LocaleKeys.transactionsOther,
          },
          color: statusColor,
          surface: TransactionsStyleMapper.statusSurface(theme, status),
          icon: TransactionsStyleMapper.statusIcon(status),
        ),
        if (reconciled != null)
          TransactionDetailPill(
            label: reconciled!
                ? LocaleKeys.transactionsMatchedSuccess
                : LocaleKeys.transactionsMatchedFailed,
            color: TransactionsStyleMapper.statusColor(
              theme,
              reconciled!
                  ? TransactionsStatus.success
                  : TransactionsStatus.other,
            ),
            surface: TransactionsStyleMapper.statusSurface(
              theme,
              reconciled!
                  ? TransactionsStatus.success
                  : TransactionsStatus.other,
            ),
            icon: reconciled! ? Icons.verified_outlined : Icons.sync,
          ),
      ],
    );
  }
}
