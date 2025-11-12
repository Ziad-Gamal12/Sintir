import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseDetailsSubscribersGridviewItemAvatar extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemAvatar(
      {super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 80,
        height: 80,
        color: Colors.grey.shade100,
        child: CustomCachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
