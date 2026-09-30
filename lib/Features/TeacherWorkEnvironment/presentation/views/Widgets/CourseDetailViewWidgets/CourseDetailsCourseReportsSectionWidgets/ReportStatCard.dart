import 'package:flutter/material.dart';

import 'ReportStatCardCornerTab.dart';
import 'ReportStatCardHorizontalContent.dart';
import 'ReportStatCardStackedContent.dart';

class ReportStatCard extends StatelessWidget {
  const ReportStatCard({
    super.key,
    required this.title,
    required this.caption,
    required this.count,
    required this.color,
    required this.icon,
    this.highlighted = false,
    this.horizontal = false,
  });

  final String title;
  final String caption;
  final int count;
  final Color color;
  final IconData icon;
  final bool highlighted;

  final bool horizontal;

  static const double _radius = 14;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final borderWidth = highlighted ? 2.0 : 1.0;

    final accent = isDark ? color : Color.lerp(color, Colors.black, 0.35)!;
    final titleColor = highlighted ? accent : scheme.onSurface;
    final captionColor = highlighted ? accent : scheme.onSurfaceVariant;

    final surface = Color.alphaBlend(
        scheme.onSurface.withValues(alpha: 0.03), scheme.surface);
    final background = highlighted
        ? Color.alphaBlend(
            color.withValues(alpha: isDark ? 0.14 : 0.08), scheme.surface)
        : surface;
    final borderColor =
        highlighted ? color : scheme.onSurface.withValues(alpha: 0.12);

    return MergeSemantics(
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius - borderWidth),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              if (horizontal)
                ReportStatCardHorizontalContent(
                  title: title,
                  count: count,
                  icon: icon,
                  accent: accent,
                  titleColor: titleColor,
                )
              else
                ReportStatCardStackedContent(
                  title: title,
                  caption: caption,
                  count: count,
                  accent: accent,
                  titleColor: titleColor,
                  captionColor: captionColor,
                ),
              if (highlighted)
                PositionedDirectional(
                  top: 0,
                  start: 0,
                  child: ReportStatCardCornerTab(color: color),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
