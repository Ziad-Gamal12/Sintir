// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/CustomPageViewItem.dart';

class Custompageview extends StatelessWidget {
  final PageController controller;
  const Custompageview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: ChoosingUserKindpageViewItemEntity.toList()
            .asMap()
            .entries
            .map((e) {
          return Custompageviewitem(
            pageViewItemEntity: e.value,
          );
        }).toList());
  }
}
