import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Search/Presentation/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterPriceSlider.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterRadioButtonItem.dart';

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
                  setState(() => pricegroupValue = value ?? "paid");
                },
                value: "paid",
                title: "مدفوع"),
            CustomFilterRadioButtonItem(
                groupValue: pricegroupValue,
                onchange: (value) {
                  context.read<CourseFilterEntity>().showFreeCourses = true;
                  setState(() => pricegroupValue = value ?? "free");
                },
                value: "free",
                title: "مجاني")
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
