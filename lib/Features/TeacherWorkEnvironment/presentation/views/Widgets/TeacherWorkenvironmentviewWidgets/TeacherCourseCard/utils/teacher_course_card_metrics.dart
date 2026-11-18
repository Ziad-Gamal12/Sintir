import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

/// Geometry and typography of the teacher course card.
///
/// The card, its loading skeleton and the grids that size it all read from
/// here, so the grid's `mainAxisExtent` always matches what the card paints.
abstract final class TeacherCourseCardMetrics {
  static const double radius = 16;
  static const double posterAspectRatio = 16 / 9;
  static const double posterOverlayInset = 8;

  /// Upper bound for system text scaling inside the card.
  static const double maxTextScale = 2.2;

  /// Fixed line-height multiplier for every text in the card body. Cairo's
  /// natural line box is ~1.87em, which wastes vertical space and makes the
  /// body height depend on font metrics. Pinning it keeps the card compact
  /// and its height predictable.
  static const double lineHeight = 1.5;

  static const EdgeInsetsDirectional bodyPadding =
      EdgeInsetsDirectional.fromSTEB(12, 10, 12, 10);
  static const double titleToMetaGap = 4;
  static const double minMetaToFooterGap = 4;
  static const double dividerExtent = 13;
  static const double iconSize = 14;
  static const double iconGap = 4;
  static const double inlineGap = 8;
  static const double chipHorizontalPadding = 8;
  static const double chipVerticalPadding = 1;

  static TextScaler textScaler(BuildContext context) =>
      MediaQuery.textScalerOf(context).clamp(maxScaleFactor: maxTextScale);

  static TextStyle titleStyle(BuildContext context) =>
      AppTextStyles(context).bold14.copyWith(height: lineHeight);

  static TextStyle priceStyle(BuildContext context) =>
      AppTextStyles(context).bold13.copyWith(height: lineHeight);

  static TextStyle metaStyle(BuildContext context) =>
      AppTextStyles(context).regular12.copyWith(height: lineHeight);

  static TextStyle footerStyle(BuildContext context) =>
      AppTextStyles(context).regular11.copyWith(height: lineHeight);

  static TextStyle chipStyle(BuildContext context) =>
      AppTextStyles(context).semiBold10.copyWith(height: lineHeight);

  /// Height of one line of [style] after (clamped) system text scaling.
  static double lineExtent(BuildContext context, TextStyle style) =>
      textScaler(context).scale(style.fontSize ?? 14) *
      (style.height ?? lineHeight);

  static double metaRowExtent(BuildContext context) => math.max(
    iconSize,
    math.max(
      lineExtent(context, priceStyle(context)),
      lineExtent(context, metaStyle(context)),
    ),
  );

  /// "New" chip height, including its 1px border on each side.
  static double chipExtent(BuildContext context) =>
      lineExtent(context, chipStyle(context)) + (chipVerticalPadding + 1) * 2;

  /// Reserves room for the "New" chip on every card so all grid cells share
  /// one height.
  static double footerRowExtent(BuildContext context) => math.max(
    iconSize,
    math.max(lineExtent(context, footerStyle(context)), chipExtent(context)),
  );

  static double bodyExtent(BuildContext context) =>
      bodyPadding.vertical +
      lineExtent(context, titleStyle(context)) +
      titleToMetaGap +
      metaRowExtent(context) +
      minMetaToFooterGap +
      dividerExtent +
      footerRowExtent(context);

  /// Total card height for a grid cell of [width].
  static double heightForWidth(BuildContext context, double width) =>
      (width / posterAspectRatio + bodyExtent(context)).ceilToDouble();
}
