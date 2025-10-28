// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomCheckBox.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';
import 'package:sintir/Features/Search/Presentation/Domain/Entities/CustomFilterEntity.dart';
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
          const _Header(),
          const SizedBox(height: 12),
          Flexible(
            // use Flexible so sheet size is adaptive inside modal bottom sheet
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: const [
                SizedBox(height: 6),
                _FilterSectionCard(
                  title: "السعر",
                  child: CustomFilterPriceSection(),
                ),
                SizedBox(height: 12),
                _FilterSectionCard(
                  title: "الأشتراك",
                  child: CustomFilterSubscribtionSection(),
                ),
                SizedBox(height: 12),
                _FilterSectionCard(
                  title: "ترتيب حسب السعر",
                  child: CustomFilterSortByPriceSection(),
                ),
                SizedBox(height: 12),
                _FilterSectionCard(
                  title: "ترتيب أضافي",
                  child: CustomFilterSortPopularityAndNewestSection(),
                ),
                SizedBox(height: 22),
                _ApplyButtonRow(),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Header with draggable handle and animated title
class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        // Drag handle center
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "فلتر الكورسات",
                style: AppTextStyles(context).semiBold20,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.close_rounded,
            size: 26,
          ),
        )
      ],
    );
  }
}

/// Reusable card wrapper for each section (animated shadow + padding)
class _FilterSectionCard extends StatefulWidget {
  final String title;
  final Widget child;

  const _FilterSectionCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  State<_FilterSectionCard> createState() => _FilterSectionCardState();
}

class _FilterSectionCardState extends State<_FilterSectionCard> {
  // small state to animate elevation on tap
  bool _pressed = false;

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: _pressed
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: AppTextStyles(context).semiBold16),
            const SizedBox(height: 10),
            widget.child,
          ],
        ),
      ),
    );
  }
}

/// Price section (keeps your logic — but improved animation)
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

/// Slider widget (kept local state)
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

/// Subscription radios (kept logic)
class CustomFilterSubscribtionSection extends StatefulWidget {
  const CustomFilterSubscribtionSection({super.key});

  @override
  State<CustomFilterSubscribtionSection> createState() =>
      _CustomFilterSubscribtionSectionState();
}

class _CustomFilterSubscribtionSectionState
    extends State<CustomFilterSubscribtionSection> {
  String subscribtiongroupValue = "-1";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomFilterRadioButtonItem(
            groupValue: subscribtiongroupValue,
            onchange: (value) {
              setState(() => subscribtiongroupValue = value ?? "-1");
              context.read<CourseFilterEntity>().showSubscribedCourses = true;
            },
            value: "subscribed",
            title: "مشترك"),
        CustomFilterRadioButtonItem(
            groupValue: subscribtiongroupValue,
            onchange: (value) {
              setState(() => subscribtiongroupValue = value ?? "0");
              context.read<CourseFilterEntity>().showUnsubscribedCourses = true;
            },
            value: "unsubscribed",
            title: "غير مشترك"),
      ],
    );
  }
}

/// Sort by price radios (kept logic)
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

/// Popularity & newest (kept logic)
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

/// Radio item — unchanged logic but small spacing improvements
class CustomFilterRadioButtonItem extends StatelessWidget {
  const CustomFilterRadioButtonItem(
      {super.key,
      required this.groupValue,
      required this.onchange,
      required this.value,
      required this.title});
  final String groupValue;
  final ValueChanged<String?> onchange;
  final String value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRadioWidget(
            value: value, onchange: onchange, groupValue: groupValue),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTextStyles(context).regular14,
        )
      ],
    );
  }
}

/// Check item — unchanged but spacing updated
class CustomFilterCheckedBoxItem extends StatelessWidget {
  const CustomFilterCheckedBoxItem(
      {super.key, required this.onChanged, required this.title});
  final ValueChanged<bool> onChanged;
  final String title;
  @override
  Widget build(BuildContext context) {
    // keep the custom checkbox implementation
    return Row(
      children: [
        Customcheckbox(
          onChanged: onChanged,
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppTextStyles(context).regular14,
        )
      ],
    );
  }
}

/// Apply button row with slight elevation and animation
class _ApplyButtonRow extends StatelessWidget {
  const _ApplyButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Custombutton(
                text: "فلتره",
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {
                  // YOU: keep apply action in place; here we close as default UX
                  // but do NOT change filtering logic
                  GoRouter.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
