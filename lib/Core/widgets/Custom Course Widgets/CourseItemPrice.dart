// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/course_price_formatter.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/locale_keys.dart';

class CourseItemPrice extends StatelessWidget {
  const CourseItemPrice({super.key, required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    final isFree = price <= 0;
    final locale = Localizations.localeOf(context).languageCode;

    return Text(
      isFree ? LocaleKeys.free : CoursePriceFormatter.egp(price, locale),
      key: const ValueKey('course-card-price'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: CourseCardMetrics.priceStyle(context).copyWith(
        color: isFree
            ? CourseCardMetrics.freeColor(context)
            : CourseCardMetrics.textColor(context),
      ),
    );
  }
}
