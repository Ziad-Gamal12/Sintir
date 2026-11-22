import 'dart:math' as math;

import 'package:flutter/widgets.dart';

enum WindowSize { compact, medium, expanded, large }

abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 840;
  static const double large = 1200;

  static WindowSize of(double width) {
    if (width >= large) return WindowSize.large;
    if (width >= expanded) return WindowSize.expanded;
    if (width >= medium) return WindowSize.medium;
    return WindowSize.compact;
  }

  static bool isWide(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    if (width >= expanded) return true;
    return width >= medium && width > constraints.maxHeight;
  }
}

abstract final class ContentWidth {
  static const double form = 640;
  static const double reading = 840;
  static const double detail = 1200;
  static const double page = 1440;

  static double gutter(double width, double maxWidth, {double min = 16}) =>
      math.max(min, (width - maxWidth) / 2);
}

extension WindowSizeContext on BuildContext {
  WindowSize get windowSize => Breakpoints.of(MediaQuery.sizeOf(this).width);
  bool get isCompactWindow => windowSize == WindowSize.compact;
  bool get hasSideNavigation =>
      MediaQuery.sizeOf(this).width >= Breakpoints.expanded;
}
