import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CoursePosterImage extends StatelessWidget {
  final String imageUrl;
  const CoursePosterImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                CustomCachedNetworkImage(fit: BoxFit.fill, imageUrl: imageUrl)),
      ),
    );
  }
}
