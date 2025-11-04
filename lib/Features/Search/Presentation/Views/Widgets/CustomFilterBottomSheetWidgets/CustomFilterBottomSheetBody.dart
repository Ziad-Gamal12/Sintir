// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/ApplyButtonRow.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterPriceSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterSortByPriceSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterSortPopularityAndNewestSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterSubscribtionSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/FilterSectionCard.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/Header.dart';
import 'package:sintir/constant.dart';

class CustomFilterBottomSheetBody extends StatefulWidget {
  const CustomFilterBottomSheetBody({super.key, required this.onFilterChanged});
  final ValueChanged<CourseFilterEntity?> onFilterChanged;

  @override
  State<CustomFilterBottomSheetBody> createState() =>
      _CustomFilterBottomSheetBodyState();
}

class _CustomFilterBottomSheetBodyState
    extends State<CustomFilterBottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    // Use ListView to avoid overflow on small screens
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Header(),
          const SizedBox(height: 12),
          Flexible(
            // use Flexible so sheet size is adaptive inside modal bottom sheet
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 6),
                const FilterSectionCard(
                  title: "السعر",
                  child: CustomFilterPriceSection(),
                ),
                const SizedBox(height: 12),
                const FilterSectionCard(
                  title: "الأشتراك",
                  child: CustomFilterSubscribtionSection(),
                ),
                const SizedBox(height: 12),
                const FilterSectionCard(
                  title: "ترتيب حسب السعر",
                  child: CustomFilterSortByPriceSection(),
                ),
                const SizedBox(height: 12),
                const FilterSectionCard(
                  title: "أضافي",
                  child: CustomFilterMoreFilters(),
                ),
                const SizedBox(height: 22),
                ApplyButtonRow(
                  onFilterChanged: widget.onFilterChanged,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
