// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// Lays out [child] like a glyph in a line of [style] text, so a [Row] with
/// [CrossAxisAlignment.baseline] centers it on the first line of the text (or
/// text field) beside it, however that text wraps, scales, or shows an error
/// underneath.
///
/// The text scale goes into the font size by hand, because a [WidgetSpan]
/// would otherwise scale [child] itself.
class LineAlignedControl extends StatelessWidget {
  const LineAlignedControl({
    super.key,
    required this.style,
    required this.child,
  });

  /// The effective style of the neighbouring text.
  final TextStyle style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fontSize = style.fontSize ?? kDefaultFontSize;
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(alignment: PlaceholderAlignment.middle, child: child),
          // Gives the line real text metrics to align against.
          const TextSpan(text: '​'),
        ],
      ),
      style: style.copyWith(
        fontSize: MediaQuery.textScalerOf(context).scale(fontSize),
      ),
      textScaler: TextScaler.noScaling,
    );
  }
}
