import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CustomSubscriberDetailsCardAvatar extends StatelessWidget {
  const CustomSubscriberDetailsCardAvatar({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child:
              CustomCachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover)),
    );
  }
}
