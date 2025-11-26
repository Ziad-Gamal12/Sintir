import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterPriceSlider.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterRadioButtonItem.dart';
import 'package:sintir/locale_keys.dart';

class CustomFilterPriceSection extends StatefulWidget {
  const CustomFilterPriceSection({super.key});

  @override
  State<CustomFilterPriceSection> createState() =>
      _CustomFilterPriceSectionState();
}

class _CustomFilterPriceSectionState extends State<CustomFilterPriceSection> {
  String pricegroupValue = "paid";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomFilterRadioButtonItem(
                groupValue: pricegroupValue,
                onchange: (value) {
                  context.read<CourseFilterEntity>().showPaidCourses = true;
                  context.read<CourseFilterEntity>().showFreeCourses = false;
                  setState(() => pricegroupValue = value ?? "paid");
                },
                value: "paid",
                title: LocaleKeys.paid),
            CustomFilterRadioButtonItem(
                groupValue: pricegroupValue,
                onchange: (value) {
                  context.read<CourseFilterEntity>().showFreeCourses = true;
                  context.read<CourseFilterEntity>().showPaidCourses = false;
                  setState(() => pricegroupValue = value ?? "free");
                },
                value: "free",
                title: LocaleKeys.free),
          ],
        ),
        const SizedBox(height: 10),
        // AnimatedCrossFade for smoother show/hide of slider
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: const CustomFilterPriceSlider(),
          crossFadeState: pricegroupValue == "paid"
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
        ),
      ],
    );
  }
}
