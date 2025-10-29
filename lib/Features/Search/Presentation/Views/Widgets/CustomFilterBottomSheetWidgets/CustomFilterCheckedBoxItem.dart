import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCheckBox.dart';

class CustomFilterCheckedBoxItem extends StatelessWidget {
  const CustomFilterCheckedBoxItem(
      {super.key, required this.onChanged, required this.title});
  final ValueChanged<bool> onChanged;
  final String title;
  @override
  Widget build(BuildContext context) {
    // keep the custom checkbox implementation
    return Row(
      children: [
        Customcheckbox(
          onChanged: onChanged,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTextStyles(context).regular14,
        )
      ],
    );
  }
}
