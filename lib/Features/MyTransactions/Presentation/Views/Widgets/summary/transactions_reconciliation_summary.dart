import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/summary/transactions_connection_pill.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/summary/transactions_reconciliation_rate.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';

class TransactionsReconciliationSummary extends StatelessWidget {
  const TransactionsReconciliationSummary({super.key, required this.state});
  final MyTransactionsState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final success = TransactionsStyleMapper.statusColor(
      theme,
      TransactionsStatus.success,
    );
    final successSurface = TransactionsStyleMapper.statusSurface(
      theme,
      TransactionsStatus.success,
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TransactionsStyleMapper.cardSurface(theme),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TransactionsStyleMapper.cardBorder(theme)),
        boxShadow: theme.brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final text = Expanded(
            child: TransactionsReconciliationRate(
              rate: state.autoReconciliationRate,
            ),
          );
          final icon = Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: successSurface,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(Icons.verified_user_rounded, color: success),
          );
          final connected = TransactionsConnectionPill(
            connected: state.isSystemConnected,
          );
          if (constraints.maxWidth < 360) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [text, const SizedBox(width: 12), icon]),
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: connected,
                ),
              ],
            );
          }
          return Row(
            children: [
              connected,
              const SizedBox(width: 10),
              text,
              const SizedBox(width: 12),
              icon,
            ],
          );
        },
      ),
    );
  }
}
