// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// Read-only row of five stars with partial fill (4.6 → four full stars and
/// 60% of the fifth). The fill starts from the reading side, so it follows
/// RTL automatically.
class StarRatingDisplay extends StatelessWidget {
  const StarRatingDisplay({
    super.key,
    required this.rating,
    this.size = 16,
    this.spacing = 1,
    this.semanticLabel,
  });

  static const Color starColor = Color(0xFFFFB400);

  /// 0 to 5.
  final double rating;
  final double size;
  final double spacing;

  /// Read by screen readers instead of the five icons, e.g. "4.6 out of 5".
  final String? semanticLabel;

  static Color emptyStarColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? Colors.white24
      : Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    final value = rating.clamp(0, 5).toDouble();
    final emptyColor = emptyStarColor(context);
    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < 5; index++) ...[
          if (index > 0) SizedBox(width: spacing),
          _PartialStar(
            fill: (value - index).clamp(0, 1).toDouble(),
            size: size,
            emptyColor: emptyColor,
          ),
        ],
      ],
    );
    return Semantics(
      label: semanticLabel,
      container: semanticLabel != null,
      child: ExcludeSemantics(child: stars),
    );
  }
}

class _PartialStar extends StatelessWidget {
  const _PartialStar({
    required this.fill,
    required this.size,
    required this.emptyColor,
  });

  final double fill;
  final double size;
  final Color emptyColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Icon(Icons.star_rounded, size: size, color: emptyColor),
          if (fill > 0)
            ClipRect(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                widthFactor: fill,
                child: Icon(
                  Icons.star_rounded,
                  size: size,
                  color: StarRatingDisplay.starColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
