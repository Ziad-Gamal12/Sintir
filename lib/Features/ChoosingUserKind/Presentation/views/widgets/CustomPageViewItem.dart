// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:svg_flutter/svg.dart';

class Custompageviewitem extends StatelessWidget {
  const Custompageviewitem({
    super.key,
    required this.pageViewItemEntity,
  });
  final ChoosingUserKindpageViewItemEntity pageViewItemEntity;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
          aspectRatio: 16 / 9,
          child: SvgPicture.asset(pageViewItemEntity.image)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
      child: Column(
        children: [
          SizedBox(
              height: height * 0.3,
              child: SvgPicture.asset(pageViewItemEntity.image)),
          const SizedBox(
            height: 35,
          ),
          Text(
            pageViewItemEntity.title,
            style: AppTextStyles(context).bold32,
          ),
          const Customsizedbox(width: 0, height: 10),
          Text(
            pageViewItemEntity.description,
            textAlign: TextAlign.center,
            style: AppTextStyles(context)
                .regular16
                .copyWith(color: const Color(0xff818181)),
          ),
        ],
      ),
    );
  }
}
