import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customcoursesinfoitemchild extends StatelessWidget {
  const Customcoursesinfoitemchild(
      {super.key,
      required this.count,
      required this.title,
      required this.textColor});
  final String count, title;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bold21.copyWith(color: textColor),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      count,
                      style:
                          AppTextStyles.bold63Auto.copyWith(color: textColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "دورة",
              style: AppTextStyles.regular21.copyWith(color: textColor),
            ),
          ],
        ),
      ],
    );
  }
}
