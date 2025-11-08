import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CourseBottomSheetCourseDetailsPrice extends StatelessWidget {
  const CourseBottomSheetCourseDetailsPrice(
      {super.key, required this.isSubscribed, required this.price});
  final bool isSubscribed;
  final int price;
  @override
  Widget build(BuildContext context) {
    if (isSubscribed == true) {
      return const SizedBox();
    } else {
      return Text.rich(
        TextSpan(children: [
          TextSpan(
              text: "السعر :  ",
              style: AppTextStyles(context)
                  .semiBold16
                  .copyWith(color: Colors.black)),
          TextSpan(
              text: " $price جنيه ",
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: KSecondaryColor))
        ]),
      );
    }
  }
}
