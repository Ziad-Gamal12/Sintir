import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CourseStudentsCount extends StatelessWidget {
  final int count;
  const CourseStudentsCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles(context).regular16,
        children: [
          TextSpan(
              text: "عدد المشتركين: ",
              style: AppTextStyles(context)
                  .regular16
                  .copyWith(color: Colors.black)),
          TextSpan(
            text: "$count",
            style: AppTextStyles(context).semiBold16.copyWith(
                  color: KMainColor,
                ),
          ),
          TextSpan(
              text: " شخص",
              style: AppTextStyles(context)
                  .regular16
                  .copyWith(color: Colors.black)),
        ],
      ),
    );
  }
}
