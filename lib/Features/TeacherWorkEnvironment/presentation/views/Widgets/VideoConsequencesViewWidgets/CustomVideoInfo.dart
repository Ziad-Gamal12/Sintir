import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomVideoInfo extends StatelessWidget {
  const CustomVideoInfo({
    super.key,
    required this.video,
  });

  final CourseVideoItemEntity video;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          video.title,
          textAlign: TextAlign.center,
          style:
              AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          video.id,
          textAlign: TextAlign.center,
          style: AppTextStyles(context).regular14.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
