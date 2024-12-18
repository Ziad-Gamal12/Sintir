import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseSectionitemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomSectionListViewItem.dart';

class CustomSectionListView extends StatelessWidget {
  const CustomSectionListView({
    super.key,
    required this.items,
  });
  final List<CourseSectionitemEntity> items;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CustomSectionListViewItem(
            item: items[index],
          ),
        );
      },
    );
  }
}
