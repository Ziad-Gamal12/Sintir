import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterRadioButtonItem.dart';

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
