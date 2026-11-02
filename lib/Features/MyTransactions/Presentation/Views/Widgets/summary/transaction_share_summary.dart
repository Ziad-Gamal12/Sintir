import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionShareSummary {
  const TransactionShareSummary._();

  static String forTransactions(
    BuildContext context,
    List<TransactionEntity> transactions,
  ) {
    return transactions
        .map((transaction) => forTransaction(context, transaction))
        .join('\n\n');
  }

  static String forTransaction(
    BuildContext context,
    TransactionEntity transaction,
  ) {
    final locale = Localizations.localeOf(context).languageCode;
    final amount = transaction.amount == null
        ? '—'
        : TransactionDisplayFormatters.fixedAmount(transaction.amount!, locale);
    final createdAt = transaction.createdAt == null
        ? null
        : intl.DateFormat.yMMMMEEEEd(
            locale,
          ).add_jm().format(transaction.createdAt!);
    final phone = transaction.mobileNumber == null
        ? null
        : TransactionDisplayFormatters.maskPhone(transaction.mobileNumber!);
    return <String>[
      '${LocaleKeys.transactionsFullNumber}: ${TransactionDisplayFormatters.fullId(transaction.transactionId)}',
      '${LocaleKeys.transactionsAmount}: $amount',
      if (transaction.currency != null)
        '${LocaleKeys.transactionsCurrency}: ${transaction.currency}',
      '${LocaleKeys.transactionsStatus}: ${_statusLabel(transaction.status)}',
      if (createdAt != null) '${LocaleKeys.transactionsCreatedAt}: $createdAt',
      if (phone != null) '${LocaleKeys.transactionsPhone}: $phone',
    ].join('\n');
  }

  static String _statusLabel(TransactionsStatus? status) => switch (status) {
    TransactionsStatus.success => LocaleKeys.transactionsSuccess,
    TransactionsStatus.pending => LocaleKeys.transactionsPending,
    TransactionsStatus.failure => LocaleKeys.transactionsFailed,
    _ => LocaleKeys.transactionsOther,
  };
}
