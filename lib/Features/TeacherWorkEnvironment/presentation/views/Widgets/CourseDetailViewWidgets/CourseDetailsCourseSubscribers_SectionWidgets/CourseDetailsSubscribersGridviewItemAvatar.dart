import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CourseDetailsSubscribersGridviewItemAvatar extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemAvatar(
      {super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: .08),
          child: imageUrl.trim().isEmpty
              ? const _AvatarFallback()
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const _AvatarFallback(),
                  errorWidget: (context, url, error) => const _AvatarFallback(),
                ),
        ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback();

  @override
  Widget build(BuildContext context) => Icon(
        Icons.person,
        size: 34,
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .65),
      );
}
