import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomSubscriberDetailsCardAvatar extends StatelessWidget {
  const CustomSubscriberDetailsCardAvatar({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl.trim(),
        fit: BoxFit.cover,
        placeholder: (context, url) => ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Icon(Icons.person_rounded,
              color: theme.colorScheme.onSurfaceVariant),
        ),
        errorWidget: (context, url, error) => ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Icon(Icons.person_rounded,
              color: theme.colorScheme.onSurfaceVariant),
        ),
        imageBuilder: (context, provider) =>
            Image(image: provider, fit: BoxFit.cover),
      ),
    );
  }
}
