// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:svg_flutter/svg.dart';

class TeacherPageViewItem extends StatelessWidget {
  final String image;
  final Widget title;
  final String description;

  const TeacherPageViewItem(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              child: SvgPicture.asset(
            image,
            fit: BoxFit.fill,
          )),
          const Customsizedbox(width: 0, height: 47.5),
          title,
          const Customsizedbox(width: 0, height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 37),
            child: Text(description,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular13
                    .copyWith(color: const Color(0xff4E5556))),
          ),
        ],
      ),
    );
  }
}
