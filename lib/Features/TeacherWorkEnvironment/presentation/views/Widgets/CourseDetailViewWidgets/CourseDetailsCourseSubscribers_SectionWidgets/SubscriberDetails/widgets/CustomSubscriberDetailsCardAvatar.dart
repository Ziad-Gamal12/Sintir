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
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CustomCachedNetworkImage(
        imageUrl: imageUrl,
      ),
    );
  }
}
