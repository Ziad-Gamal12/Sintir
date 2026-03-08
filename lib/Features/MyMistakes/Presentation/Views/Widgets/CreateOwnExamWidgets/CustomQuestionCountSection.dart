import 'package:flutter/material.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CustomQuestionSlider.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/QuestionCountHeader.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/QuickPickSelector.dart';

class CustomQuestionCountSection extends StatefulWidget {
  const CustomQuestionCountSection({super.key, required this.onCountChanged});
  final Function(int) onCountChanged;

  @override
  State<CustomQuestionCountSection> createState() =>
      _CustomQuestionCountSectionState();
}

class _CustomQuestionCountSectionState
    extends State<CustomQuestionCountSection> {
  double _currentValue = 10;
  final List<int> quickPicks = [5, 10, 20, 30, 50];

  void _updateValue(double newValue) {
    setState(() => _currentValue = newValue);
    widget.onCountChanged(newValue.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionCountHeader(count: _currentValue.toInt()),
        const SizedBox(height: 20),
        CustomQuestionSlider(
          value: _currentValue,
          onChanged: _updateValue,
        ),
        const SizedBox(height: 16),
        QuickPickSelector(
          currentValue: _currentValue.toInt(),
          options: quickPicks,
          onSelected: (count) => _updateValue(count.toDouble()),
        ),
      ],
    );
  }
}
