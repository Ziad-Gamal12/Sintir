import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CustomCountWidget.dart';

class Coursetestviewbodydetailsitem extends StatelessWidget {
  const Coursetestviewbodydetailsitem(
      {super.key,
      required this.title,
      required this.count,
      required this.countColor,
      required this.countTextColor});
  final String title, count;
  final Color countColor, countTextColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.semiBold14.copyWith(color: Colors.black),
          ),
          CustomCountWidget(
              countColor: countColor,
              count: count,
              countTextColor: countTextColor)
        ],
      ),
    );
  }
}
