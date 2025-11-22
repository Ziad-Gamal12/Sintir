import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class CoursefedbackslistviewItem extends StatelessWidget {
  const CoursefedbackslistviewItem({super.key, required this.item});
  final CoursefeedbackItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        titleAlignment: ListTileTitleAlignment.top,
        minLeadingWidth: 60,
        title: Text(
          item.name,
          style:
              AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            item.fedBack,
            style: AppTextStyles(context).light14.copyWith(color: Colors.black),
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CustomCachedNetworkImage(
            imageUrl: item.userImage,
          ),
        ),
        trailing: Text(
          "${item.datePosted.year}/${item.datePosted.month}/${item.datePosted.day}",
          style: AppTextStyles(context)
              .regular14
              .copyWith(color: const Color(0xff818181)),
        ),
      ),
    );
  }
}
