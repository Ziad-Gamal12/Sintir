import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomContentCreatorCircleAvartar extends StatelessWidget {
  const CustomContentCreatorCircleAvartar({
    super.key,
    required this.imagepath,
  });
  final String imagepath;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: CachedNetworkImage(
          imageUrl: imagepath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
