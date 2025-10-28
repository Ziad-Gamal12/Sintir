import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Search/Presentation/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterRadioButtonItem.dart';

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
            },
            value: "asc",
            title: "الأقل للأعلى"),
        CustomFilterRadioButtonItem(
            groupValue: sortByPricegroupValue,
            onchange: (value) {
              setState(() => sortByPricegroupValue = value ?? "");
              context.read<CourseFilterEntity>().sortByHighestPrice = true;
            },
            value: "desc",
            title: "الأعلى للأقل"),
      ],
    );
  }
}
