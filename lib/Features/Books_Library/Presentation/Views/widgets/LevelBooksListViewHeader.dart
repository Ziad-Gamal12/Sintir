import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomDropdownButton.dart';

class Levelbookslistviewheader extends StatelessWidget {
  Levelbookslistviewheader({super.key});
  String? currentValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("الكتب المتوفرة",
            style: AppTextStyles.bold13.copyWith(color: Colors.black)),
        const Spacer(),
        CustomDropdownButton(
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
            })
      ],
    );
  }
}
