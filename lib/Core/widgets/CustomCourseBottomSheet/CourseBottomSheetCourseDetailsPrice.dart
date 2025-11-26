import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseBottomSheetCourseDetailsPrice extends StatelessWidget {
  const CourseBottomSheetCourseDetailsPrice({
    super.key,
    required this.isSubscribed,
    required this.price,
  });

  final bool isSubscribed;
  final int price;

  @override
  Widget build(BuildContext context) {
    if (isSubscribed) {
      return const SizedBox();
    } else {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "${LocaleKeys.coursePriceLabel} : ",
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: Colors.black),
            ),
            TextSpan(
              text: " $price ${LocaleKeys.priceEgp} ",
              style: AppTextStyles(context)
                  .bold20
                  .copyWith(color: KSecondaryColor),
            ),
          ],
        ),
      );
    }
  }
}
