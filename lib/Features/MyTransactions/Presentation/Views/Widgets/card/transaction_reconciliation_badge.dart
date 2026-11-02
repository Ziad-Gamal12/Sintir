import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionReconciliationBadge extends StatelessWidget {
  const TransactionReconciliationBadge({super.key, required this.isMatched});
  final bool? isMatched;

  @override
  Widget build(BuildContext context) {
    final matched = isMatched == true;
    final status = matched
        ? TransactionsStatus.success
        : TransactionsStatus.other;
    final color = TransactionsStyleMapper.statusColor(
      Theme.of(context),
      status,
    );
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 3, 8, 3),
      decoration: BoxDecoration(
        color: TransactionsStyleMapper.statusSurface(Theme.of(context), status),
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
