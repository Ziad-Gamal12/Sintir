import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/constant.dart';

class CustomFilterPriceSlider extends StatefulWidget {
  const CustomFilterPriceSlider({super.key});

  @override
  State<CustomFilterPriceSlider> createState() =>
      _CustomFilterPriceSliderState();
}

class _CustomFilterPriceSliderState extends State<CustomFilterPriceSlider> {
  double sliderValue = 100;

  @override
  void initState() {
    super.initState();
    // initialize with provider value if exists (non-breaking)
    final maxPrice = context.read<CourseFilterEntity>().maxPrice;
    if (maxPrice != null) {
      sliderValue = maxPrice;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // value label row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("أقل سعر 0", style: AppTextStyles(context).regular13),
            Row(
              children: [
                Text("أقصى سعر", style: AppTextStyles(context).regular13),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    "  ${sliderValue.round()} جنيه",
                    key: ValueKey(sliderValue.round()),
                    style: AppTextStyles(context)
                        .semiBold14
                        .copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: KMainColor,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: KMainColor,
            overlayColor: KMainColor.withOpacity(0.12),
            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          ),
          child: Slider(
            min: 0,
            max: 2000,
            label: sliderValue.round().toString(),
            divisions: 100,
            value: sliderValue,
            onChanged: (value) {
              // keep state local to avoid rebuilding parent sections
              setState(() {
                sliderValue = value;
              });
              // update entity as before
              context.read<CourseFilterEntity>().maxPrice = sliderValue;
            },
          ),
        ),
      ],
    );
  }
}
