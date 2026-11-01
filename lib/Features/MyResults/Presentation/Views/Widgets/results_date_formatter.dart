import 'package:flutter/widgets.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';

class ResultsDateFormatter {
  static String format(BuildContext context, DateTime date) =>
      LocaleFormatter.date(date, Localizations.localeOf(context).toString());

  static String number(BuildContext context, num value) =>
      LocaleFormatter.number(value, Localizations.localeOf(context).toString());
}
