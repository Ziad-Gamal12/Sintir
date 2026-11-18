// ignore_for_file: file_names

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';

abstract final class TeacherWorkspaceCourseCardMetrics {
  static const double actionHeight = 36;
  static const double contentIconSize = 14;

  static double contentLineHeight(BuildContext context) => math.max(
    contentIconSize,
    CourseCardMetrics.lineHeight(
      context,
      CourseCardMetrics.captionStyle(context),
    ),
  );

  static double bottomHeight(BuildContext context) =>
      math.max(actionHeight, CourseCardMetrics.priceHeight(context));

  static double detailsHeight(BuildContext context) =>
      CourseCardMetrics.detailsPadding.vertical +
      CourseCardMetrics.titleBlockHeight(context) +
      CourseCardMetrics.rowGap +
      CourseCardMetrics.metaHeight(context) +
      CourseCardMetrics.rowGap +
      contentLineHeight(context) +
      CourseCardMetrics.priceGap +
      bottomHeight(context);

  static double heightForWidth(BuildContext context, double width) =>
      CourseCardMetrics.heightForDetails(width, detailsHeight(context));
}
