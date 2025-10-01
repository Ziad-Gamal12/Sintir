// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseContentCreatorListTile extends StatelessWidget {
  const CourseContentCreatorListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });
  final String title, image;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        minLeadingWidth: 24,
        titleAlignment: ListTileTitleAlignment.center,
        horizontalTitleGap: 10,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
              AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
        ),
        leading: SizedBox(
          width: 40,
          child: Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CustomCachedNetworkImage(
                    imageUrl: image,
                  ))),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles(context)
              .regular13
              .copyWith(color: const Color(0xffAAAAAA)),
        ));
  }
}
