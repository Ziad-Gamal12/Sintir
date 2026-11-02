import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/PaymentStatusPalette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/transaction_details_sheet.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final status =
        TransactionsStyleMapper.statusColor(theme, transaction.status);
    final methodColor = TransactionsStyleMapper.methodColor(
        theme, transaction.method, transaction.status);
    final locale = Localizations.localeOf(context).languageCode;
    final amount = transaction.amount == null
        ? '—'
        : '${LocaleFormatter.number(transaction.amount!, locale)} ${_currencyLabel(transaction.currency, locale)}'
            .trim();
    final created = transaction.createdAt;
    final date = created == null
        ? ''
        : intl.DateFormat(
                'd MMM yyyy', Localizations.localeOf(context).languageCode)
            .format(created);
    final time = created == null
        ? ''
        : intl.DateFormat(
                'h:mm a', Localizations.localeOf(context).languageCode)
            .format(created);
    final isToday =
        created != null && DateUtils.isSameDay(created, DateTime.now());
    final isYesterday = created != null &&
        DateUtils.isSameDay(
            created, DateTime.now().subtract(const Duration(days: 1)));
    final timeLabel = isToday || isYesterday ? time : date;

    return Semantics(
      button: true,
      label: '${transaction.method}, $amount, ${_statusLabel(context)}',
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => showTransactionDetails(context, transaction),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border:
                  Border.all(color: theme.dividerColor.withValues(alpha: .24)),
              boxShadow: theme.brightness == Brightness.light
                  ? [
                      BoxShadow(
                          color: theme.shadowColor.withValues(alpha: .04),
                          blurRadius: 8,
                          offset: const Offset(0, 3))
                    ]
                  : null,
            ),
            child: Column(children: [
              Row(children: [
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        color: methodColor.withValues(
                            alpha:
                                theme.brightness == Brightness.dark ? .18 : .1),
                        borderRadius: BorderRadius.circular(13)),
                    child: Icon(
                        TransactionsStyleMapper.methodIcon(transaction.method,
                            status: transaction.status),
                        color: methodColor)),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(_methodLabel(context),
                          style: styles.semiBold14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      if (transaction.issuer?.isNotEmpty == true)
                        Text(transaction.issuer!,
                            style: styles.regular12.copyWith(
                                color: theme.colorScheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                    ])),
                const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(amount,
                          style: styles.semiBold16.copyWith(
                              color: transaction.status ==
                                      TransactionsStatus.failure
                                  ? status
                                  : theme.colorScheme.onSurface),
                          maxLines: 1)),
                  const SizedBox(height: 4),
                  _StatusBadge(
                      status: transaction.status, label: _statusLabel(context)),
                ]),
              ]),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                      height: 1,
                      color: theme.dividerColor.withValues(alpha: .35))),
              Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(_shortId(transaction.transactionId),
                              style: styles.regular11.copyWith(
                                  letterSpacing: .35,
                                  color: theme.colorScheme.onSurfaceVariant),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      IconButton(
                          tooltip: LocaleKeys.transactionsCopy,
                          visualDensity: VisualDensity.compact,
                          constraints:
                              const BoxConstraints(minWidth: 40, minHeight: 40),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: transaction.transactionId));
                            await HapticFeedback.selectionClick();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(LocaleKeys.transactionsCopied),
                                      duration: const Duration(seconds: 2)));
                            }
                          },
                          icon: const Icon(Icons.copy_outlined, size: 15)),
                    ]),
                    Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                            transaction.mobileNumber == null
                                ? LocaleKeys.transactionsPhoneUnavailable
                                : TransactionsStyleMapper.maskPhone(
                                    transaction.mobileNumber!),
                            style: styles.regular11.copyWith(
                                color: theme.colorScheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                    _ReconciliationBadge(isMatched: transaction.isReconciled),
                    if (timeLabel.isNotEmpty)
                      Text(timeLabel,
                          style: styles.regular11.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                  ]),
            ]),
          ),
        ),
      ),
    );
  }

  String _shortId(String id) {
    final parts = id.split('-');
    if (parts.length > 2 && parts.first.toUpperCase() == 'TXN') {
      return parts.take(2).join('-');
    }
    return id.length > 12 ? id.substring(0, 12) : id;
  }

  String _currencyLabel(String? currency, String locale) =>
      switch ((currency, locale)) {
        ('EGP', 'ar') => 'ج.م',
        ('SAR', 'ar') => 'ر.س',
        (final value?, _) => value,
        _ => '',
      };
  String _methodLabel(BuildContext context) {
    final value = transaction.method.toLowerCase();
    if (value.contains('card') || value.contains('بطاقة')) {
      return LocaleKeys.transactionsBankCard;
    }
    if (value.contains('wallet') ||
        value.contains('mobile') ||
        value.contains('محفظ')) {
      return LocaleKeys.transactionsWallet;
    }
    if (value.contains('fawry') ||
        value.contains('outlet') ||
        value.contains('فوري')) {
      return LocaleKeys.transactionsFawry;
    }
    if (value.contains('cash') || value.contains('نقد')) {
      return LocaleKeys.transactionsCash;
    }
    if (value.contains('transfer') ||
        value.contains('instapay') ||
        value.contains('تحويل')) {
      return LocaleKeys.transactionsDirectTransfer;
    }
    return transaction.method;
  }

  String _statusLabel(BuildContext context) => switch (transaction.status) {
        TransactionsStatus.success => LocaleKeys.transactionsSuccess,
        TransactionsStatus.pending => LocaleKeys.transactionsPending,
        TransactionsStatus.failure => LocaleKeys.transactionsFailed,
        _ => LocaleKeys.transactionsOther,
      };
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.label});
  final dynamic status;
  final String label;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 2),
      decoration: BoxDecoration(
          color:
              TransactionsStyleMapper.statusSurface(Theme.of(context), status),
          borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(TransactionsStyleMapper.statusIcon(status),
            size: 13,
            color:
                TransactionsStyleMapper.statusColor(Theme.of(context), status)),
        const SizedBox(width: 4),
        Text(label,
            style: AppTextStyles(context).regular11.copyWith(
                color: TransactionsStyleMapper.statusColor(
                    Theme.of(context), status)))
      ]));
}

class _ReconciliationBadge extends StatelessWidget {
  const _ReconciliationBadge({required this.isMatched});
  final bool? isMatched;
  @override
  Widget build(BuildContext context) {
    final colors = PaymentStatusPalette.forTheme(Theme.of(context));
    final matched = isMatched == true;
    return Container(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 3, 8, 3),
        decoration: BoxDecoration(
            color: matched ? colors.successSurface : colors.informationSurface,
            borderRadius: BorderRadius.circular(7)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(matched ? Icons.done_all : Icons.sync,
              size: 13, color: matched ? colors.success : colors.information),
          const SizedBox(width: 4),
          Text(
              matched
                  ? LocaleKeys.transactionsMatched
                  : LocaleKeys.transactionsUnmatched,
              style: AppTextStyles(context).regular10.copyWith(
                  color: matched ? colors.success : colors.information))
        ]));
  }
}
