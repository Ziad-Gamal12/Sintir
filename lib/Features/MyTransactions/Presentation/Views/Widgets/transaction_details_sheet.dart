import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/PaymentStatusPalette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

Future<void> showTransactionDetails(
    BuildContext context, TransactionEntity transaction) {
  if (MediaQuery.sizeOf(context).width >= 900) {
    return showDialog<void>(
        context: context,
        builder: (_) => Dialog(
            child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 720, maxHeight: 760),
                child: _TransactionDetailsSheet(transaction: transaction))));
  }
  return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TransactionDetailsSheet(transaction: transaction));
}

class _TransactionDetailsSheet extends StatelessWidget {
  const _TransactionDetailsSheet({required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final colors = PaymentStatusPalette.forTheme(theme);
    final statusColor =
        TransactionsStyleMapper.statusColor(theme, transaction.status);
    final locale = Localizations.localeOf(context).languageCode;
    final amount = transaction.amount == null
        ? '—'
        : LocaleFormatter.number(transaction.amount!, locale);
    final currency = transaction.currency == 'EGP'
        ? 'ج.م'
        : transaction.currency == 'SAR'
            ? 'ر.س'
            : transaction.currency;
    final created = transaction.createdAt;
    final date = created == null
        ? null
        : intl.DateFormat('EEEE، d MMMM yyyy — h:mm a', locale).format(created);
    final method = _methodLabel(transaction.method);

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * .9, maxWidth: 720),
      child: Container(
        decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24))),
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Center(
                child: Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(5)))),
            const SizedBox(height: 16),
            Row(children: [
              IconButton.filledTonal(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded)),
              const SizedBox(width: 10),
              Icon(Icons.receipt_long_outlined,
                  color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(LocaleKeys.transactionsDetails,
                        style: styles.semiBold20),
                    Text(
                        '${LocaleKeys.transactionsSystemReference}: #${transaction.transactionId}',
                        style: styles.regular11.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)
                  ])),
            ]),
            const SizedBox(height: 18),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      theme.colorScheme.primary.withValues(alpha: .13),
                      theme.colorScheme.primary.withValues(alpha: .04)
                    ]),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  Text(
                      transaction.status == TransactionsStatus.failure
                          ? LocaleKeys.transactionsAmount
                          : LocaleKeys.transactionsTotalCollected,
                      style: styles.regular12
                          .copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('$amount ${currency ?? ''}'.trim(),
                          style: styles.bold30
                              .copyWith(color: theme.colorScheme.onSurface))),
                  const SizedBox(height: 12),
                  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Pill(
                            label: _statusLabel(transaction.status),
                            color: statusColor,
                            surface: TransactionsStyleMapper.statusSurface(
                                theme, transaction.status),
                            icon: TransactionsStyleMapper.statusIcon(
                                transaction.status)),
                        if (transaction.isReconciled != null)
                          _Pill(
                              label: transaction.isReconciled!
                                  ? LocaleKeys.transactionsMatchedSuccess
                                  : LocaleKeys.transactionsMatchedFailed,
                              color: transaction.isReconciled!
                                  ? colors.success
                                  : colors.information,
                              surface: transaction.isReconciled!
                                  ? colors.successSurface
                                  : colors.informationSurface,
                              icon: transaction.isReconciled!
                                  ? Icons.verified_outlined
                                  : Icons.sync),
                      ]),
                ])),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: .55),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  _DetailRow(
                      icon: Icons.tag,
                      label: LocaleKeys.transactionsFullNumber,
                      value: transaction.transactionId,
                      copy: true),
                  if (date != null)
                    _DetailRow(
                        icon: Icons.calendar_today_outlined,
                        label: LocaleKeys.transactionsCreatedAt,
                        value: date),
                  _DetailRow(
                      icon: Icons.credit_card_outlined,
                      label: LocaleKeys.transactionsPaymentMethod,
                      value: method),
                  if (transaction.issuer?.isNotEmpty == true)
                    _DetailRow(
                        icon: Icons.account_balance_outlined,
                        label: LocaleKeys.transactionsIssuer,
                        value: transaction.issuer!),
                  if (transaction.mobileNumber?.isNotEmpty == true)
                    _DetailRow(
                        icon: Icons.phone_iphone,
                        label: LocaleKeys.transactionsPhone,
                        value: TransactionsStyleMapper.maskPhone(
                            transaction.mobileNumber!),
                        ltr: true),
                  if (transaction.isReconciled != null)
                    _DetailRow(
                        icon: Icons.verified_user_outlined,
                        label: LocaleKeys.transactionsReconciliation,
                        value: transaction.isReconciled!
                            ? LocaleKeys.transactionsMatchedSuccess
                            : LocaleKeys.transactionsMatchedFailed,
                        valueColor: transaction.isReconciled!
                            ? colors.success
                            : colors.information),
                  if (transaction.currency != null)
                    _DetailRow(
                        icon: Icons.currency_exchange,
                        label: LocaleKeys.transactionsCurrency,
                        value: transaction.currency == 'EGP'
                            ? LocaleKeys.transactionsCurrencyEgp
                            : transaction.currency == 'SAR'
                                ? LocaleKeys.transactionsCurrencySar
                                : transaction.currency!),
                ])),
          ]),
        ),
      ),
    );
  }

  static String _methodLabel(String value) {
    final lower = value.toLowerCase();
    if (lower.contains('card') || lower.contains('بطاقة')) {
      return LocaleKeys.transactionsBankCardDetail;
    }
    if (lower.contains('wallet') ||
        lower.contains('mobile') ||
        lower.contains('محفظ')) {
      return LocaleKeys.transactionsWallet;
    }
    if (lower.contains('fawry') ||
        lower.contains('outlet') ||
        lower.contains('فوري')) {
      return LocaleKeys.transactionsFawry;
    }
    if (lower.contains('cash') || lower.contains('نقد')) {
      return LocaleKeys.transactionsCash;
    }
    if (lower.contains('transfer') ||
        lower.contains('bank') ||
        lower.contains('تحويل')) {
      return LocaleKeys.transactionsDirectTransfer;
    }
    return value;
  }
}

String _statusLabel(TransactionsStatus? status) => switch (status) {
      TransactionsStatus.success => LocaleKeys.transactionsSuccess,
      TransactionsStatus.pending => LocaleKeys.transactionsPending,
      TransactionsStatus.failure => LocaleKeys.transactionsFailed,
      _ => LocaleKeys.transactionsOther,
    };

class _Pill extends StatelessWidget {
  const _Pill(
      {required this.label,
      required this.color,
      required this.surface,
      required this.icon});
  final String label;
  final Color color, surface;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
          color: surface, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 5),
        Text(label,
            style: AppTextStyles(context).regular11.copyWith(color: color))
      ]));
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(
      {required this.icon,
      required this.label,
      required this.value,
      this.copy = false,
      this.ltr = false,
      this.valueColor});
  final IconData icon;
  final String label, value;
  final bool copy, ltr;
  final Color? valueColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 8, 10),
        decoration: BoxDecoration(
            color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
              flex: 4,
              child: Text(label,
                  style: AppTextStyles(context)
                      .regular11
                      .copyWith(color: theme.colorScheme.onSurfaceVariant))),
          const SizedBox(width: 8),
          Expanded(
              flex: 6,
              child: Directionality(
                  textDirection:
                      ltr ? TextDirection.ltr : Directionality.of(context),
                  child: Text(value,
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles(context).regular12.copyWith(
                          color: valueColor ?? theme.colorScheme.onSurface)))),
          if (copy)
            IconButton(
                tooltip: LocaleKeys.transactionsCopy,
                visualDensity: VisualDensity.compact,
                onPressed: () => Clipboard.setData(ClipboardData(text: value)),
                icon: const Icon(Icons.copy_outlined, size: 16)),
        ]));
  }
}
