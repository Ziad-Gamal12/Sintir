import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionStatusBadge extends StatelessWidget {
  const TransactionStatusBadge({super.key, required this.status});
  final TransactionsStatus? status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = TransactionsStyleMapper.statusColor(theme, status);
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
      decoration: BoxDecoration(
        color: TransactionsStyleMapper.statusSurface(theme, status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            TransactionsStyleMapper.statusIcon(status),
            size: 13,
            color: color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              _statusLabel(status),
              style: AppTextStyles(context).regular11.copyWith(color: color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(TransactionsStatus? status) => switch (status) {
    TransactionsStatus.success => LocaleKeys.transactionsSuccess,
    TransactionsStatus.pending => LocaleKeys.transactionsPending,
    TransactionsStatus.failure => LocaleKeys.transactionsFailed,
    _ => LocaleKeys.transactionsOther,
  };
}
