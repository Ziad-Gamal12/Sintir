import 'package:intl/intl.dart';

/// Shared locale aware date and number formatting for user facing values.
class LocaleFormatter {
  const LocaleFormatter._();

  static String date(DateTime value, String locale) =>
      _latinize(DateFormat('dd/MM/yyyy', locale).format(value));

  static String number(num value, String locale) =>
      _latinize(NumberFormat.decimalPattern(locale).format(value));

  static String _latinize(String value) => value.replaceAllMapped(
        RegExp('[٠-٩۰-۹]'),
        (match) {
          final code = match.group(0)!.runes.single;
          final start = code >= 0x06F0 ? 0x06F0 : 0x0660;
          return String.fromCharCode(0x30 + code - start);
        },
      );
}
