import 'package:flutter/material.dart';

extension ReportSurfaceColors on ColorScheme {
  Color get reportPanelFill =>
      Color.alphaBlend(onSurface.withValues(alpha: 0.04), surface);

  Color get reportPanelBorder => onSurface.withValues(alpha: 0.12);
}
