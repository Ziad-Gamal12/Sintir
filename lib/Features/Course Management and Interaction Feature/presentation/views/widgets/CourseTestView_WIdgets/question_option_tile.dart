import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRadioWidget(
          value: value,
          groupValue: groupValue,
          onchange: onChanged,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
