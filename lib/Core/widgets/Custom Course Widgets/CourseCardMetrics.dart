// ignore_for_file: file_names

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

abstract final class CourseCardMetrics {
  static const double imageAspectRatio = 16 / 9;
  static const double maxTextScale = 1.15;
  static const double radius = 16;
  static const EdgeInsets detailsPadding = EdgeInsets.fromLTRB(12, 10, 12, 12);
  static const double rowGap = 6;
  static const double priceGap = 8;
  static const double avatarSize = 20;
  static const Duration newBadgeWindow = Duration(days: 14);
  static const int minStudentsToShow = 10;

  static TextScaler textScaler(BuildContext context) =>
      MediaQuery.textScalerOf(context).clamp(maxScaleFactor: maxTextScale);

  static TextStyle titleStyle(BuildContext context) =>
      _fixedHeight(AppTextStyles(context).semiBold14);

  static TextStyle captionStyle(BuildContext context) =>
      _fixedHeight(AppTextStyles(context).regular12);

  static TextStyle captionStrongStyle(BuildContext context) =>
      _fixedHeight(AppTextStyles(context).bold12);

  static TextStyle priceStyle(BuildContext context) =>
      _fixedHeight(AppTextStyles(context).bold16);

  static TextStyle _fixedHeight(TextStyle style) => style.copyWith(
        height: 1.4,
        leadingDistribution: TextLeadingDistribution.even,
      );

  static double lineHeight(BuildContext context, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(
        text: 'Ag',
        style: DefaultTextStyle.of(context).style.merge(style),
      ),
      textDirection: Directionality.of(context),
      textScaler: textScaler(context),
      locale: Localizations.maybeLocaleOf(context),
      maxLines: 1,
    )..layout();
    final height = painter.height;
    painter.dispose();
    return height;
  }

  static double titleBlockHeight(BuildContext context) =>
      lineHeight(context, titleStyle(context)) * 2;

  static double creatorRowHeight(BuildContext context) =>
      math.max(avatarSize, lineHeight(context, captionStyle(context)));

  static double metaHeight(BuildContext context) => math.max(
        lineHeight(context, captionStyle(context)),
        lineHeight(context, captionStrongStyle(context)),
      );

  static double priceHeight(BuildContext context) =>
      lineHeight(context, priceStyle(context));

  static double detailsHeight(BuildContext context) =>
      detailsPadding.vertical +
      titleBlockHeight(context) +
      rowGap +
      creatorRowHeight(context) +
      rowGap +
      metaHeight(context) +
      priceGap +
      priceHeight(context);

  static double heightForDetails(double width, double detailsHeight) =>
      (width / imageAspectRatio + detailsHeight + 2).ceilToDouble();

  static double heightForWidth(BuildContext context, double width) =>
      heightForDetails(width, detailsHeight(context));

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color surfaceColor(BuildContext context) =>
      _isDark(context) ? const Color(0xFF1E1E1E) : Colors.white;

  static Color borderColor(BuildContext context) => _isDark(context)
      ? Colors.white.withValues(alpha: .08)
      : Colors.black.withValues(alpha: .06);

  static Color textColor(BuildContext context) =>
      _isDark(context) ? Colors.white : const Color(0xFF1A1A1A);

  static Color mutedColor(BuildContext context) => _isDark(context)
      ? Colors.white.withValues(alpha: .64)
      : Colors.black.withValues(alpha: .62);

  static Color accentColor(BuildContext context) =>
      _isDark(context) ? const Color(0xFF8FA8F0) : const Color(0xFF2F55C8);

  static Color freeColor(BuildContext context) =>
      _isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF157A3F);

  static Color placeholderColor(BuildContext context) =>
      _isDark(context) ? const Color(0xFF262626) : const Color(0xFFEEF1F5);

  static Color iconBackground(BuildContext context) =>
      KMainColor.withValues(alpha: _isDark(context) ? .18 : .10);

  static List<BoxShadow>? shadow(BuildContext context) => _isDark(context)
      ? null
      : [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ];
}

class CourseCardGridDelegate extends SliverGridDelegate {
  const CourseCardGridDelegate({
    required this.detailsHeight,
    this.spacing = 16,
  });

  factory CourseCardGridDelegate.of(
    BuildContext context, {
    double spacing = 16,
  }) =>
      CourseCardGridDelegate(
        detailsHeight: CourseCardMetrics.detailsHeight(context),
        spacing: spacing,
      );

  final double detailsHeight;
  final double spacing;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final count = GridHelper.getCrossAxisCount(constraints.crossAxisExtent);
    final itemWidth = math.max(
      0.0,
      (constraints.crossAxisExtent - spacing * (count - 1)) / count,
    );
    final itemHeight = CourseCardMetrics.heightForDetails(
      itemWidth,
      detailsHeight,
    );
    return SliverGridRegularTileLayout(
      crossAxisCount: count,
      mainAxisStride: itemHeight + spacing,
      crossAxisStride: itemWidth + spacing,
      childMainAxisExtent: itemHeight,
      childCrossAxisExtent: itemWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(CourseCardGridDelegate oldDelegate) =>
      oldDelegate.detailsHeight != detailsHeight ||
      oldDelegate.spacing != spacing;
}
