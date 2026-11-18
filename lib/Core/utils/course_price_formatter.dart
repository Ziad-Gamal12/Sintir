import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/locale_keys.dart';

class CoursePriceFormatter {
  const CoursePriceFormatter._();

  static String egp(num amount, String locale) =>
      LocaleKeys.priceEgpAmount(LocaleFormatter.number(amount, locale));

  static String fromCents(int cents, String locale) =>
      LocaleKeys.priceEgpAmount(_amount(cents, locale));

  static String discountFromCents(int cents, String locale) =>
      LocaleKeys.priceEgpAmount('⁦−${_amount(cents.abs(), locale)}⁩');

  static String _amount(int cents, String locale) => LocaleFormatter.number(
        cents % 100 == 0 ? cents ~/ 100 : cents / 100,
        locale,
      );
}
