import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StudentAvatar extends StatelessWidget {
  const StudentAvatar({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: .14),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: url.trim(),
              fit: BoxFit.cover,
              placeholder: (context, path) => Icon(
                Icons.person_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              errorWidget: (context, path, error) => Icon(
                Icons.person_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
