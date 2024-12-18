import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseSectionitemEntity.dart';

class CustomSectionListViewItem extends StatelessWidget {
  const CustomSectionListViewItem({super.key, required this.item});
  final CourseSectionitemEntity item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.navigationScreen(context: context),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: AlignmentDirectional.center,
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8)),
          child: Customlisttilewidget(
            title: item.title,
            image: item.preffixImage,
            trailing: Text(
              "${item.durationTime} دقائق",
              style: AppTextStyles.regular11
                  .copyWith(color: const Color(0xff818181)),
            ),
          )),
    );
  }
}
