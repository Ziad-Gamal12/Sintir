import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';

class QuestionOptionTile extends StatelessWidget {
  const QuestionOptionTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  static const double _lineHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles(
      context,
    ).regular16.copyWith(height: _lineHeight);

    // Pad the text so its first line sits on the radio's vertical center,
    // letting long answers wrap downward instead of being cut off.
    final radioExtent =
        kMinInteractiveDimension +
        Theme.of(context).visualDensity.baseSizeAdjustment.dy;
    final lineExtent =
        MediaQuery.textScalerOf(context).scale(textStyle.fontSize ?? 16) *
        _lineHeight;
    final verticalPadding = math.max(0.0, (radioExtent - lineExtent) / 2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRadioWidget(
          value: value,
          groupValue: groupValue,
          onchange: onChanged,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Text(value, style: textStyle),
          ),
        ),
      ],
    );
  }
}
