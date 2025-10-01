import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/AddcoursesectionOptionItem.dart';
import 'package:svg_flutter/svg.dart';

class Addcoursesectioncontentitem extends StatelessWidget {
  const Addcoursesectioncontentitem({super.key, required this.item});
  final Addcoursesectionoptionitem item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: const Color(0xffF3F2F7),
          child: SvgPicture.asset(item.icon),
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
