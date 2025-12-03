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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MaterialButton(
      height: 54,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:
              isDark ? Colors.white.withOpacity(.15) : const Color(0xffDDDFDF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
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
            const SizedBox(width: 40),
            Text(
              text,
              style: AppTextStyles(context).semiBold16.copyWith(
                    color: isDark ? Colors.white : const Color(0xff0C0D0D),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
