import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterCheckedBoxItem.dart';

class CustomFilterSortPopularityAndNewestSection extends StatefulWidget {
  const CustomFilterSortPopularityAndNewestSection({super.key});

  @override
  State<CustomFilterSortPopularityAndNewestSection> createState() =>
      _CustomFilterSortPopularityAndNewestSectionState();
}

class _CustomFilterSortPopularityAndNewestSectionState
    extends State<CustomFilterSortPopularityAndNewestSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomFilterCheckedBoxItem(
            onChanged: (value) {
              context.read<CourseFilterEntity>().sortByPopularity = true;
            },
            title: "الشعبية"),
        CustomFilterCheckedBoxItem(
            onChanged: (value) {
              context.read<CourseFilterEntity>().sortByNewest = true;
            },
            title: "الجديدة")
      ],
    );
  }
}
