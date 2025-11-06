import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseItemImage extends StatelessWidget {
  const CourseItemImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomCachedNetworkImage(imageUrl: imageUrl),
      ),
    );
  }
}
