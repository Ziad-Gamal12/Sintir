// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCheckBox.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/constant.dart';

class Customtermsandconditiona extends StatelessWidget {
  const Customtermsandconditiona(
      {super.key, required this.textonpressed, required this.onchanged});
  final VoidCallback textonpressed;
  final ValueChanged<bool> onchanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Customcheckbox(onChanged: onchanged),
        const Customsizedbox(width: 16, height: 0),
        Expanded(
          child: GestureDetector(
            onTap: textonpressed,
            child: SizedBox(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "من خلال إنشاء حساب ، فإنك توافق على",
                    style: AppTextStyles.semiBold13Auto
                        .copyWith(color: const Color(0xff949D9E))),
                const TextSpan(text: " "),
                TextSpan(
                    text: "الشروط والأحكام الخاصة بنا ",
                    style: AppTextStyles.semiBold13Auto
                        .copyWith(color: KSecondaryColor))
              ])),
            ),
          ),
        )
      ],
    );
  }
}
