import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CreatorAvatar extends StatelessWidget {
  final String imageUrl;

  const CreatorAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xff7F5AFF),
            Color(0xff5F9BFF),
          ],
        ),
      ),
      child: CircleAvatar(
        radius: 52,
        backgroundColor: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: CustomCachedNetworkImage(imageUrl: imageUrl),
        ),
      ),
    );
  }
}
