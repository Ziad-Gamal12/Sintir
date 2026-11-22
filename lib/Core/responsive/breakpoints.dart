import 'package:flutter/widgets.dart';

/// Window size classes, aligned with Material 3:
/// compact < 600 ≤ medium < 840 ≤ expanded.
enum WindowSize { compact, medium, expanded }

abstract final class Breakpoints {
  static const double medium = 600;
  static const double expanded = 840;

  static WindowSize of(double width) {
    if (width >= expanded) return WindowSize.expanded;
    if (width >= medium) return WindowSize.medium;
    return WindowSize.compact;
  }

  /// True when there is enough room to put two panes side by side:
  /// any expanded width, or a medium width held in landscape.
  static bool isWide(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    if (width >= expanded) return true;
    return width >= medium && width > constraints.maxHeight;
  }
}

extension WindowSizeContext on BuildContext {
  WindowSize get windowSize => Breakpoints.of(MediaQuery.sizeOf(this).width);
  bool get isCompactWindow => windowSize == WindowSize.compact;
}
