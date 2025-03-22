// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomFileListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomTestListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomVedioListViewItem.dart';

class CustomSectionListView extends StatelessWidget {
  const CustomSectionListView({
    super.key,
    required this.items,
  });
  final List items;
  Widget getChild(dynamic item, BuildContext context) {
    if (item is Coursevedioitementity) {
      return CustomVedioListViewItem(item: item);
    } else if (item is Coursetestentity) {
      return Customtestlistviewitem(item: item);
    } else {
      return Customfilelistviewitem(
        item: item,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: getChild(items[index], context));
      },
    );
  }
}
