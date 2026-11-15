// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseItemPrice extends StatelessWidget {
  const CourseItemPrice({super.key, required this.price});

  final int price;

  static const String _freeLabel = 'مجاني';
  static const String _currency = 'ج.م';

  static String _format(int n) => n.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isFree = price <= 0;

    final color = isFree
        ? (isDark ? const Color(0xFF4ADE80) : const Color(0xFF1F9D55))
        : Theme.of(context).colorScheme.primary;

    return Text(
      isFree ? _freeLabel : '${_format(price)} $_currency',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles(context).semiBold14.copyWith(color: color),
    );
  }
}
