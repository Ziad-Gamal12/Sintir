import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sintir/Core/Utils/textStyles.dart';

class OnboardingPageviewItem extends StatelessWidget {
  final String svgPicture;
  final Widget title;

  final String description;

  const OnboardingPageviewItem(
      {super.key,
      required this.svgPicture,
      required this.description,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(svgPicture, height: 300, width: 300),
        SizedBox(height: 10),
        title,
        SizedBox(height: 10),
        Text(description,
            textAlign: TextAlign.center,
            style: textStyles.textStyle14.copyWith(color: Color(0xff4E5556)))
      ],
    );
  }
}
