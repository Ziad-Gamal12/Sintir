import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentAvatar extends StatelessWidget {
  const StudentAvatar({
    super.key,
    required this.url,
    this.name = '',
    this.ringColor,
  });

  final String url;

  /// Used for the initials fallback when there is no image (or it fails).
  final String name;

  /// Optional status ring (e.g. pass / fail color).
  final Color? ringColor;

  static const double _imageSize = 48;

  String _initials() {
    final words =
        name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '';
    return words
        .take(2)
        .map((w) => String.fromCharCode(w.runes.first))
        .join()
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final imageUrl = url.trim();
    final initials = _initials();

    Widget fallback() => Center(
          child: initials.isEmpty
              ? Icon(
                  Icons.person_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                )
              : Text(
                  initials,
                  style: style.semiBold16
                      .copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
        );

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ringColor ?? theme.dividerColor, width: 2),
      ),
      child: ClipOval(
        child: SizedBox.square(
          dimension: _imageSize,
          child: ColoredBox(
            color: theme.colorScheme.surfaceContainerHighest,
            child: imageUrl.isEmpty
                ? fallback()
                : CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    // Decode at the displayed size (48dp * 3) instead of full resolution.
                    memCacheWidth: 144,
                    placeholder: (_, __) => fallback(),
                    errorWidget: (_, __, ___) => fallback(),
                  ),
          ),
        ),
      ),
    );
  }
}
