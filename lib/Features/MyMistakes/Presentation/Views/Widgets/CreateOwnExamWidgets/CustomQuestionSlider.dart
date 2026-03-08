import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';

class CustomQuestionSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomQuestionSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: KMainColor,
        inactiveTrackColor: isDarkMode ? Colors.white10 : Colors.grey.shade200,
        trackHeight: 8.0,
        thumbColor: KMainColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
        overlayColor: KMainColor.withAlpha(32),
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: KMainColor,
        valueIndicatorTextStyle: const TextStyle(color: Colors.white),
      ),
      child: Slider(
        value: value,
        min: 5,
        max: 50,
        divisions: 9,
        label: value.round().toString(),
        onChanged: onChanged,
      ),
    );
  }
}
