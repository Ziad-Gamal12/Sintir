// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg.dart';

class Customstudentsocialbutton extends StatelessWidget {
  final void Function() onPressed;
  final String iconpath;
  final String text;
  const Customstudentsocialbutton(
      {super.key,
      required this.onPressed,
      required this.iconpath,
      required this.text});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 54,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xffDDDFDF), width: 1),
          borderRadius: BorderRadius.circular(16)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconpath,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 53,
            ),
            Text(
              text,
              style: AppTextStyles.semiBold16
                  .copyWith(color: const Color(0xff0C0D0D)),
            )
          ],
        ),
      ),
    );
  }
}
