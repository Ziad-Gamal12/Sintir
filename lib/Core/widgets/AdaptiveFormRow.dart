// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// Lays form fields side by side when the form is wide enough, and stacks
/// them otherwise. The widget tree keeps the same shape in both modes
/// (Flex + Flexible), so field state survives a rotation.
class AdaptiveFormRow extends StatelessWidget {
  const AdaptiveFormRow({
    super.key,
    required this.children,
    this.minRowWidth = 520,
    this.spacing = 16,
    this.runSpacing = 12,
  });

  final List<Widget> children;

  /// Form width from which the children share one row.
  final double minRowWidth;

  /// Gap between children in a row.
  final double spacing;

  /// Gap between children when stacked.
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inRow = constraints.maxWidth >= minRowWidth;
        return Flex(
          direction: inRow ? Axis.horizontal : Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              inRow ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
          spacing: inRow ? spacing : runSpacing,
          children: [
            for (final child in children)
              Flexible(
                // flex 0 = sized by its content when stacked.
                flex: inRow ? 1 : 0,
                fit: FlexFit.tight,
                child: child,
              ),
          ],
        );
      },
    );
  }
}
