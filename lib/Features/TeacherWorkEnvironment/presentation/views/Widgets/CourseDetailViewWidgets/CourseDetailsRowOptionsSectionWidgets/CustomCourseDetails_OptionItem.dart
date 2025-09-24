import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/constant.dart';

class CustomcoursedetailsOptionitem extends StatelessWidget {
  const CustomcoursedetailsOptionitem(
      {super.key, required this.item, required this.isSelected});
  final CoursedetailsviewOptionitemEntity item;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          item.imageurl,
          color: isSelected ? KMainColor : Colors.black,
        ),
        Text(
          item.title,
          style: AppTextStyles.regular10.copyWith(
            color: isSelected ? KMainColor : Colors.black,
          ),
        )
      ],
    );
  }
}
