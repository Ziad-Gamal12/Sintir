import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/DisplayVediRequiresEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';

class CustomVedioListViewItem extends StatelessWidget {
  const CustomVedioListViewItem({super.key, required this.item});
  final Displayvedirequiresentity item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item.vedioEntity.ontap(context: context, requires: item),
      child: Customcontainersectionitem(
          child: Customlisttilewidget(
        title: item.vedioEntity.title,
        image: item.vedioEntity.preffixImage,
        trailing: Text(
          "${item.vedioEntity.durationTime} دقائق",
          style:
              AppTextStyles.regular11.copyWith(color: const Color(0xff818181)),
        ),
      )),
    );
  }
}
