import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class EditCourseSaveButton extends StatelessWidget {
  const EditCourseSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Custombutton(
      text: "حفظ التعديلات",
      color: KMainColor,
      textColor: Colors.white,
      onPressed: () {},
    );
  }
}
