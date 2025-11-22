import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class SolutionImageOverlay extends StatelessWidget {
  const SolutionImageOverlay({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CustomCachedNetworkImage(imageUrl: imageUrl),
      ),
    );
  }
}
