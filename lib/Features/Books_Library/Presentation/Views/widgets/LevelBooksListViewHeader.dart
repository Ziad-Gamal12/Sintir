// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomDropdownButton.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';

class Levelbookslistviewheader extends StatelessWidget {
  Levelbookslistviewheader({super.key});
  String? currentValue;
  @override
  Widget build(BuildContext context) {
    return CustomListORGridTextHeader(
      text: "الكتب المتوفرة",
      trailing: CustomDropdownButton(
          items: const [
            DropdownMenuItem(
              value: "جميع الكتب",
              child: Text("جميع الكتب"),
            ),
            DropdownMenuItem(
              value: "الكتب الجديدة",
              child: Text("الكتب الجديدة"),
            ),
          ],
          hintText: "جميع الكتب",
          valueChanged: (value) {
            currentValue = value;
          }),
    );
  }
}
