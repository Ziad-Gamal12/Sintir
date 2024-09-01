// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

class Custompageviewitem extends StatelessWidget {
  const Custompageviewitem(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.onPressed});
  final String image;
  final String title;
  final String description;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: AspectRatio(
        aspectRatio: 2 / 4,
        child: Container(
          height: height * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffF5F5F5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
            child: Column(
              children: [
                Container(child: SvgPicture.asset(image)),
                const Customsizedbox(
                  height: 35,
                  width: 0,
                ),
                Text(
                  title,
                  style: AppTextStyles.bold32Auto,
                ),
                const Customsizedbox(width: 0, height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular16
                      .copyWith(color: const Color(0xff818181)),
                ),
                const Spacer(),
                Custombutton(
                    text: "ابدأ ألان",
                    color: KSecondaryColor,
                    textColor: Colors.white,
                    onPressed: onPressed)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
