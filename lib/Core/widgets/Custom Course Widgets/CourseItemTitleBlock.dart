// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';

class CourseItemTitleBlock extends StatelessWidget {
  const CourseItemTitleBlock({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: CourseCardMetrics.titleStyle(context).copyWith(
        color: CourseCardMetrics.textColor(context),
      ),
    );
  }
}
