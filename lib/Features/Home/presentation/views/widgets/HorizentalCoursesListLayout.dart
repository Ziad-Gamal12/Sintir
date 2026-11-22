import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';

class HorizentalCoursesListLayout {
  const HorizentalCoursesListLayout._({
    required this.itemWidth,
    required this.height,
    required this.spacing,
    required this.clipBehavior,
    this.padding,
  });

  factory HorizentalCoursesListLayout.of(BuildContext context, double width) {
    if (width < Breakpoints.expanded) {
      final itemWidth = (width * .44).clamp(150.0, 230.0).toDouble();
      return HorizentalCoursesListLayout._(
        itemWidth: itemWidth,
        height: CourseCardMetrics.heightForWidth(context, itemWidth),
        spacing: 12,
        clipBehavior: Clip.none,
      );
    }
    final columns = GridHelper.getCrossAxisCount(width);
    final itemWidth = (width - gridSpacing * (columns - 1)) / columns;
    return HorizentalCoursesListLayout._(
      itemWidth: itemWidth,
      height:
          CourseCardMetrics.heightForWidth(context, itemWidth) +
          _shadowInset * 2,
      spacing: gridSpacing,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(vertical: _shadowInset),
    );
  }

  static const double gridSpacing = 16;
  static const double _shadowInset = 8;

  final double itemWidth;
  final double height;
  final double spacing;
  final Clip clipBehavior;
  final EdgeInsets? padding;
}
