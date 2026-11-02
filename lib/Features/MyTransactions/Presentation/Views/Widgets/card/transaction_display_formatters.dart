import 'package:sintir/locale_keys.dart';

class TransactionDisplayFormatters {
  const TransactionDisplayFormatters._();

  static String maskPhone(String value) {
    if (value.contains('*')) return value;
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 4) return value;
    final prefixLength = digits.length > 10 ? digits.length - 10 + 4 : 4;
    final prefix = digits.substring(
      0,
      prefixLength.clamp(1, digits.length - 4),
    );
    return '+$prefix *** ${digits.substring(digits.length - 4)}';
  }

  static String methodLabel(String value) {
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
