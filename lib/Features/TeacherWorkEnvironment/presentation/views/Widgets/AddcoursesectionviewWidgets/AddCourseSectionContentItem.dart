import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/AddcoursesectionOptionItem.dart';
import 'package:svg_flutter/svg.dart';

class AddCourseSectionContentItem extends StatelessWidget {
  const AddCourseSectionContentItem({super.key, required this.item});
  final Addcoursesectionoptionitem item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
              ),
            ],
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            item.icon,
            color: Colors.black,
            height: 28,
            width: 28,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          item.title,
          style:
              AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
        )
      ],
    );
  }
}
