import 'package:flutter/material.dart';

class FilterDateRangePicker {
  const FilterDateRangePicker._();

  static Future<DateTimeRange?> pick(
    BuildContext context, {
    DateTime? start,
    DateTime? end,
  }) => showDateRangePicker(
    context: context,
    firstDate: DateTime(2018),
    lastDate: DateTime.now(),
    initialDateRange: start != null && end != null
        ? DateTimeRange(start: start, end: end)
        : null,
    builder: (context, child) => Theme(data: Theme.of(context), child: child!),
  );
}
