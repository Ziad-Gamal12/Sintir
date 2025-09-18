// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteWidget.dart';
import 'package:sintir/constant.dart';

class CustomSendNoteText extends StatefulWidget {
  const CustomSendNoteText({
    super.key,
  });

  @override
  State<CustomSendNoteText> createState() => _CustomSendNoteTextState();
}

class _CustomSendNoteTextState extends State<CustomSendNoteText> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Variables.DisplaycoursevedioveiwScaffoldKey.currentState!
            .showBottomSheet((context) {
          return CustomSendNoteWidget(controller: controller);
        });
      },
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: " لقد واجهنى بعض المشاكل؟  ",
            style: AppTextStyles.regular11.copyWith(color: Colors.black)),
        TextSpan(
            text: "أرسال ملاحظة",
            style: AppTextStyles.regular11.copyWith(color: KSecondaryColor))
      ])),
    );
  }
}
