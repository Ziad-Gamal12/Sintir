// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CustomContentCreatorCircleAvartar extends StatelessWidget {
  const CustomContentCreatorCircleAvartar({
    super.key,
    required this.imagepath,
    this.radius = 15,
  });
  final String imagepath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius * 3),
          child: CustomCachedNetworkImage(imageUrl: imagepath),
        ),
      ),
    );
  }
}
