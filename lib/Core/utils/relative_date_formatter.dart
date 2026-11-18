import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/locale_keys.dart';

class RelativeDateFormatter {
  const RelativeDateFormatter._();

  static String format(
    DateTime date, {
    required DateTime now,
    required String locale,
  }) {
    final elapsed = now.difference(date);
    if (elapsed.inMinutes < 1) return LocaleKeys.reportTimeJustNow;
    if (elapsed.inHours < 1) {
      return LocaleKeys.minutesAgo(elapsed.inMinutes, locale);
    }
    if (elapsed.inHours < 24) {
      return LocaleKeys.hoursAgo(elapsed.inHours, locale);
    }
    final days = _calendarDaysBetween(date, now);
    if (days <= 1) return LocaleKeys.transactionsYesterday;
    if (days < 7) return LocaleKeys.daysAgo(days, locale);
    return LocaleFormatter.longDate(date, locale);
  }

  static int _calendarDaysBetween(DateTime from, DateTime to) {
    final start = DateTime.utc(from.year, from.month, from.day);
    final end = DateTime.utc(to.year, to.month, to.day);
    return end.difference(start).inDays;
  }
}
