import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseDetailsSubscribersGridviewItemAvatar extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemAvatar({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: CustomCachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
