import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterRadioButtonItem.dart';
import 'package:sintir/locale_keys.dart';

class CustomFilterSortByPriceSection extends StatefulWidget {
  const CustomFilterSortByPriceSection({super.key});

  @override
  State<CustomFilterSortByPriceSection> createState() =>
      _CustomFilterSortByPriceSectionState();
}

class _CustomFilterSortByPriceSectionState
    extends State<CustomFilterSortByPriceSection> {
  String sortByPricegroupValue = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomFilterRadioButtonItem(
            groupValue: sortByPricegroupValue,
            onchange: (value) {
              setState(() => sortByPricegroupValue = value ?? "");
              context.read<CourseFilterEntity>().sortByLowestPrice = true;
              context.read<CourseFilterEntity>().sortByHighestPrice = false;
            },
            value: "asc",
            title: LocaleKeys.lowestToHighest),
        CustomFilterRadioButtonItem(
            groupValue: sortByPricegroupValue,
            onchange: (value) {
              setState(() => sortByPricegroupValue = value ?? "");
              context.read<CourseFilterEntity>().sortByHighestPrice = true;
              context.read<CourseFilterEntity>().sortByLowestPrice = false;
            },
            value: "desc",
            title: LocaleKeys.highestToLowest),
      ],
    );
  }
}
