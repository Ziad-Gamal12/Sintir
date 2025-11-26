import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterRadioButtonItem.dart';
import 'package:sintir/locale_keys.dart';

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
              context.read<CourseFilterEntity>().showUnsubscribedCourses = true;
            },
            value: "subscribed",
            title: LocaleKeys.subscribed),
        CustomFilterRadioButtonItem(
            groupValue: subscribtiongroupValue,
            onchange: (value) {
              setState(() => subscribtiongroupValue = value ?? "0");
              context.read<CourseFilterEntity>().showUnsubscribedCourses = true;
              context.read<CourseFilterEntity>().showSubscribedCourses = false;
            },
            value: "unsubscribed",
            title: LocaleKeys.unsubscribed),
      ],
    );
  }
}
