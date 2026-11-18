// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/locale_keys.dart';

class StarRatingInput extends StatelessWidget {
  const StarRatingInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 40,
    this.enabled = true,
    this.keyPrefix = 'star-rating-input',
  });

  final int value;
  final ValueChanged<int> onChanged;
  final double size;
  final bool enabled;

  final String keyPrefix;

  static Color idleColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? Colors.white54
      : Colors.black45;

  @override
  Widget build(BuildContext context) {
    final emptyColor = idleColor(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var star = 1; star <= 5; star++)
          Semantics(
            container: true,
            button: true,
            enabled: enabled,
            selected: star == value,
            label: LocaleKeys.rateWithStars(star),
            child: InkResponse(
              key: ValueKey('$keyPrefix-$star'),
              onTap: enabled ? () => onChanged(star) : null,
              radius: size * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ExcludeSemantics(
                  child: AnimatedScale(
                    scale: star <= value ? 1 : 0.9,
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      star <= value
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: size,
                      color: star <= value
                          ? StarRatingDisplay.starColor
                          : emptyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
