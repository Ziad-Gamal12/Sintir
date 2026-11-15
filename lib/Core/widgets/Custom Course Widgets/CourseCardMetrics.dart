// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

abstract final class CourseCardMetrics {
  static const double imageAspectRatio = 16 / 9;
  static const double maxTextScale = 1.15;

  static const EdgeInsets detailsPadding = EdgeInsets.fromLTRB(10, 8, 10, 6);
  static const double titleToMetaGap = 6;
  static const double minMetaToCreatorGap = 8;
  static const double creatorHeight = 40;

  static TextScaler textScaler(BuildContext context) =>
      MediaQuery.textScalerOf(context).clamp(maxScaleFactor: maxTextScale);

  static TextStyle resolve(BuildContext context, TextStyle style) =>
      DefaultTextStyle.of(context).style.merge(style);

  static double lineHeight(BuildContext context, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: 'Ag', style: resolve(context, style)),
      textDirection: Directionality.of(context),
      textScaler: textScaler(context),
      locale: Localizations.maybeLocaleOf(context),
    )..layout();
    final h = painter.height;
    painter.dispose();
    return h;
  }

  static double titleBlockHeight(BuildContext context) =>
      lineHeight(context, AppTextStyles(context).semiBold12) * 2 + 2;

  static double metaHeight(BuildContext context) =>
      lineHeight(context, AppTextStyles(context).semiBold14);

  static double detailsHeight(BuildContext context) =>
      detailsPadding.vertical +
      titleBlockHeight(context) +
      titleToMetaGap +
      metaHeight(context) +
      minMetaToCreatorGap +
      creatorHeight;

  static double heightForWidth(BuildContext context, double width) =>
      width / imageAspectRatio + detailsHeight(context) + 1;
}
