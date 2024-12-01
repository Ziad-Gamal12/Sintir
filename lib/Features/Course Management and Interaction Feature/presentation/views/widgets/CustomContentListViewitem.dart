import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomSectionListView.dart';

class CustomContentListViewitem extends StatelessWidget {
  const CustomContentListViewitem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.grey.shade100,
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(),
        header: Customlisttilewidget(
          title: "المحاضرة الأولى",
          image: Assets.assetsImagesSectionIcon,
          subtitle: "شرح الدرس الثانى والثالث",
        ),
        collapsed: const SizedBox(),
        expanded: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const CustomSectionListView(),
        ),
      ),
    );
  }
}
