import 'package:intl/intl.dart' as intl;
import 'package:sintir/locale_keys.dart';

class TransactionDisplayFormatters {
  const TransactionDisplayFormatters._();

  static String maskPhone(String value) {
    var digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('20')) digits = digits.substring(2);
    if (digits.startsWith('0')) digits = digits.substring(1);
    if (digits.length < 6) return value;
    return '+20 ${digits.substring(0, 2)} *** ${digits.substring(digits.length - 4)}';
  }

  static String shortId(String id) {
    final canonical = _canonicalId(id);
    final token = canonical.split('-').first;
    return 'TXN-${token.substring(0, token.length.clamp(0, 6))}';
  }

  static String fullId(String id) => 'TXN-${_canonicalId(id)}-SNT';

  static String fixedAmount(num amount, String locale) =>
      _latinize(intl.NumberFormat('0.00', locale).format(amount));

  static String _canonicalId(String id) => id
      .trim()
      .replaceFirst(RegExp(r'^TXN-', caseSensitive: false), '')
      .replaceFirst(RegExp(r'-SNT$', caseSensitive: false), '');

  static String _latinize(String value) =>
      value.replaceAllMapped(RegExp('[٠-٩۰-۹]'), (match) {
        final code = match.group(0)!.runes.single;
        final start = code >= 0x06F0 ? 0x06F0 : 0x0660;
        return String.fromCharCode(0x30 + code - start);
      });

  static String issuerLabel(String value) =>
      value.trim().toLowerCase() == 'paymob'
      ? LocaleKeys.transactionsIssuerPaymob
      : value.trim();

  static String currencyLabel(String value) => switch (value) {
    'EGP' => LocaleKeys.transactionsCurrencyEgp,
    'SAR' => LocaleKeys.transactionsCurrencySar,
    _ => value,
  };
}
