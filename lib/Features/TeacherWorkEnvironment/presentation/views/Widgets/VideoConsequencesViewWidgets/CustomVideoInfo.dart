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
    final ThemeData theme = Theme.of(context);
    final Color titleColor = theme.textTheme.bodyLarge!.color!;
    final Color idColor = theme.textTheme.bodySmall!.color!.withOpacity(0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          video.title,
          textAlign: TextAlign.center,
          style: AppTextStyles(context).semiBold20.copyWith(color: titleColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          video.id,
          textAlign: TextAlign.center,
          style: AppTextStyles(context).regular14.copyWith(color: idColor),
        ),
      ],
    );
  }
}
