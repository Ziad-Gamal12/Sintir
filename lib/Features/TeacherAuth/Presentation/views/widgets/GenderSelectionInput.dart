// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/constant.dart';

class GenderSelectionInput extends StatelessWidget {
  const GenderSelectionInput({
    super.key,
    required this.onChanged,
    required this.radiovalue,
  });
  final ValueChanged<String?> onChanged;
  final String radiovalue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Radio(
                    activeColor: KMainColor,
                    value: "ذكر",
                    groupValue: radiovalue,
                    onChanged: onChanged),
                const Customsizedbox(width: 20, height: 0),
                Text(
                  "ذكر",
                  style: AppTextStyles.bold14Auto
                      .copyWith(color: const Color(0xff818181)),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                    activeColor: KMainColor,
                    value: "أنثى",
                    groupValue: radiovalue,
                    onChanged: onChanged),
                const Customsizedbox(width: 20, height: 0),
                Text(
                  "أنثى",
                  style: AppTextStyles.bold14Auto
                      .copyWith(color: const Color(0xff818181)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
