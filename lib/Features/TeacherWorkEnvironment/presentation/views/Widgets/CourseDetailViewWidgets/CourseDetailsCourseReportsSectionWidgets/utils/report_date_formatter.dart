import 'package:intl/intl.dart';
import 'package:sintir/locale_keys.dart';

typedef ReportTranslator = String Function(String key,
    {Map<String, String>? args});

class ReportDateFormatter {
  const ReportDateFormatter._();

  static String date(DateTime value, String locale) =>
      DateFormat('d MMM yyyy', locale).format(value);
  static String fullDateTime(DateTime value, String locale) =>
      DateFormat('d MMMM yyyy, h:mm a', locale).format(value);

  static String dateWithRelative(
      DateTime value, DateTime now, String locale, ReportTranslator tr) {
    final relative = relativeTime(value, now, locale, tr);
    return relative == null
        ? date(value, locale)
        : '${date(value, locale)} · $relative';
  }

  static String? relativeTime(
      DateTime value, DateTime now, String locale, ReportTranslator tr) {
    final age = now.difference(value);
    if (age.isNegative) return tr('report_time_just_now');
    if (age.inDays >= 30) return null;
    if (age.inMinutes < 1) return tr('report_time_just_now');
    if (age.inMinutes < 60) return _plural('minute', age.inMinutes, locale, tr);
    if (age.inHours < 24) return _plural('hour', age.inHours, locale, tr);
    return _plural('day', age.inDays, locale, tr);
  }

  static String _plural(
      String unit, int count, String locale, ReportTranslator tr) {
    final form = count == 1
        ? 'one'
        : count == 2
            ? 'two'
            : locale.startsWith('ar') && count >= 3 && count <= 10
                ? 'few'
                : 'many';
    final key = 'report_time_${unit}_$form';
    return form == 'few' || form == 'many'
        ? tr(key, args: {'count': '$count'})
        : tr(key);
  }
}
