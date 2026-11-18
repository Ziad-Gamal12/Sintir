import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseItemImage extends StatelessWidget {
  const CourseItemImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return ColoredBox(
        key: const ValueKey('course-image-placeholder'),
        color: CourseCardMetrics.placeholderColor(context),
        child: Center(
          child: Icon(
            Icons.image_outlined,
            size: 28,
            color: CourseCardMetrics.mutedColor(context),
          ),
        ),
      );
    }
    return CustomCachedNetworkImage(imageUrl: imageUrl);
  }
}
