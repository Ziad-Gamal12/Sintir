import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/constant.dart';

class CustomSendNoteWidget extends StatelessWidget {
  const CustomSendNoteWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: 20),
      height: MediaQuery.sizeOf(context).height * .35,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: Colors.black, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ارسال ملاحظه",
            style: AppTextStyles.bold20Auto.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Customteaxtfield(
              maxLines: 4,
              hintText: "اكتب ملاحظتك هنا",
              obscureText: false,
              controller: controller,
              textInputType: TextInputType.text,
              validator: (value) {
                return null;
              }),
          const Spacer(),
          Custombutton(
              text: "ارسال",
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {})
        ],
      ),
    );
  }
}
