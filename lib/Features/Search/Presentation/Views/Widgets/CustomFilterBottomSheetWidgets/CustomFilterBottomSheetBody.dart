// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/ApplyButtonRow.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterPriceSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterSortByPriceSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterSortPopularityAndNewestSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterSubscribtionSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/FilterSectionCard.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/Header.dart';
import 'package:sintir/constant.dart';

class CustomFilterBottomSheetBody extends StatefulWidget {
  const CustomFilterBottomSheetBody({super.key});

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
              children: const [
                SizedBox(height: 6),
                FilterSectionCard(
                  title: "السعر",
                  child: CustomFilterPriceSection(),
                ),
                SizedBox(height: 12),
                FilterSectionCard(
                  title: "الأشتراك",
                  child: CustomFilterSubscribtionSection(),
                ),
                SizedBox(height: 12),
                FilterSectionCard(
                  title: "ترتيب حسب السعر",
                  child: CustomFilterSortByPriceSection(),
                ),
                SizedBox(height: 12),
                FilterSectionCard(
                  title: "ترتيب أضافي",
                  child: CustomFilterSortPopularityAndNewestSection(),
                ),
                SizedBox(height: 22),
                ApplyButtonRow(),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
