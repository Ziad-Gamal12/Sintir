import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

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

  /// Optional custom ring color. Defaults to a very subtle SINTIR primary outline
  /// to maintain brand harmony without competing with score or semantic status.
  final Color? ringColor;

  static const double _imageSize = 46;

  String _initials() {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
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
    final isDark = theme.brightness == Brightness.dark;
    final style = AppTextStyles(context);
    final imageUrl = url.trim();
    final initials = _initials();

    // Delicate 1.0px outline with reduced opacity to avoid competing with card content
    final effectiveRingColor =
        ringColor ??
        (isDark
            ? KMainColor.withValues(alpha: 0.18)
            : KMainColor.withValues(alpha: 0.14));

    Widget fallback() => Center(
      child: initials.isEmpty
          ? Icon(
              Icons.person_rounded,
              size: 24,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            )
          : Text(
              initials,
              style: style.semiBold16.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
    );

    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: effectiveRingColor, width: 1.0),
      ),
      child: ClipOval(
        child: SizedBox.square(
          dimension: _imageSize,
          child: ColoredBox(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: isDark ? 0.6 : 0.8,
            ),
            child: imageUrl.isEmpty
                ? fallback()
                : CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    // Decode at the displayed size (46dp * 3) instead of full resolution.
                    memCacheWidth: 138,
                    placeholder: (_, _) => fallback(),
                    errorWidget: (_, _, _) => fallback(),
                  ),
          ),
        ),
      ),
    );
  }
}
