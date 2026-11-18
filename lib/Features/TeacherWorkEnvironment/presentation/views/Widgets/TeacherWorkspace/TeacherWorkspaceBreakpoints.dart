// ignore_for_file: file_names

import 'dart:math' as math;

enum WorkEnvironmentBreakpoint {
  compact,
  medium,
  expanded;

  static WorkEnvironmentBreakpoint fromWidth(double width) {
    if (width >= 1024) return WorkEnvironmentBreakpoint.expanded;
    if (width >= 600) return WorkEnvironmentBreakpoint.medium;
    return WorkEnvironmentBreakpoint.compact;
  }
}

class TeacherWorkEnvironmentLayout {
  const TeacherWorkEnvironmentLayout._();

  static const double compactMaxWidth = 600.0;
  static const double mediumMaxWidth = 1024.0;
  static const double maxContentWidth = 1360.0;
  static const double startPaneWidth = 380.0;
  static const double gridGap = 12.0;
  static const double minCardWidth = 210.0;

  static int getGridColumnCount(double availableWidth) {
    if (availableWidth < 600) return 2;
    final count = ((availableWidth + gridGap) / (minCardWidth + gridGap))
        .floor();
    return math.max(2, count);
  }
}
