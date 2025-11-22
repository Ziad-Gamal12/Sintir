// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindDescription.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindTitle.dart';
import 'package:sintir/constant.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: height * 0.4,
              child: SvgPicture.asset(pageViewItemEntity.image)),
          const SizedBox(
            height: 16,
          ),
          ChoosingUserKindTitle(title: pageViewItemEntity.title),
          const SizedBox(height: 8),
          ChoosingUserKindDescription(
              description: pageViewItemEntity.description),
        ],
      ),
    );
  }
}
