// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseItemStudentsCount extends StatelessWidget {
  const CourseItemStudentsCount({super.key, required this.count});

  final int count;

  static String _compact(int n) {
    if (n >= 1000000) return '${_trim(n / 1000000)}M';
    if (n >= 1000) return '${_trim(n / 1000)}K';
    return '$n';
  }

  static String _trim(double v) {
    final s = v.toStringAsFixed(1);
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.white60 : Colors.grey.shade600;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.people_alt_outlined, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          _compact(count),
          maxLines: 1,
          style: AppTextStyles(context).regular12.copyWith(color: color),
        ),
      ],
    );
  }
}
