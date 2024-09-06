import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../Core/utils/textStyles.dart';

class Custom_button extends StatelessWidget {
  final String text;
  final Color? logoColor;
  final double? padding;
  final String image;
  const Custom_button({
    super.key,
    required this.text,
    this.padding,
    this.logoColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xffDDDFDF))),
        height: 55,
        child: Row(
          children: [
            SvgPicture.asset(image),
            SizedBox(
              width: padding,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: AppTextStyles.semiBold16.fontWeight,
                fontSize: AppTextStyles.bold16Auto.fontSize,
                color: const Color(0xff0C0D0D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
