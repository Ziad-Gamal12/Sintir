import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';

class CustomFilterRadioButtonItem extends StatelessWidget {
  const CustomFilterRadioButtonItem(
      {super.key,
      required this.groupValue,
      required this.onchange,
      required this.value,
      required this.title});
  final String groupValue;
  final ValueChanged<String?> onchange;
  final String value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRadioWidget(
            value: value, onchange: onchange, groupValue: groupValue),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTextStyles(context).regular14,
        )
      ],
    );
  }
}
