import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSubscriberDetailsCardAvatar extends StatelessWidget {
  const CustomSubscriberDetailsCardAvatar({
    super.key,
    required this.imageUrl,
    required this.name,
  });
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.trim();
    final fallback = _Fallback(name: name);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: url.isEmpty
          ? fallback
          : CachedNetworkImage(
              imageUrl: url,
              memCacheWidth: 192,
              fit: BoxFit.cover,
              placeholder: (_, __) => fallback,
              errorWidget: (_, __, ___) => fallback,
              imageBuilder: (_, provider) =>
                  Image(image: provider, fit: BoxFit.cover),
            ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => String.fromCharCode(part.runes.first))
        .join();
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: initials.isEmpty
            ? Icon(Icons.person_rounded,
                color: theme.colorScheme.onSurfaceVariant)
            : Text(initials.toUpperCase(),
                style: AppTextStyles(context)
                    .semiBold16
                    .copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ),
    );
  }
}
