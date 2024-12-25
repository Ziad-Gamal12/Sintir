// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';

class CourseTestViewBodyTestButtonsActions extends StatelessWidget {
  const CourseTestViewBodyTestButtonsActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Custombutton(
            text: "تسليم الأمتحان",
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () {}),
        const SizedBox(
          height: 10,
        ),
        Custombutton(
            text: "اكمال الأمتحان لاحقا",
            color: Colors.yellow.shade700,
            textColor: Colors.white,
            onPressed: () {}),
      ],
    );
  }
}
