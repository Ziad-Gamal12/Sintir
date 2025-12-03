// ignore_for_file: must_be_immutable, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/locale_keys.dart';

class Addcourseposter extends StatelessWidget {
  const Addcourseposter({
    super.key,
    this.coursePosterImage,
    this.coursePosterUrl,
    required this.onTap,
  });

  final File? coursePosterImage;
  final String? coursePosterUrl;
  final VoidCallback onTap;

  bool get _hasImage => coursePosterImage != null || coursePosterUrl != null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: _hasImage ? _buildImageView(context) : _buildPlaceholder(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Use background color that contrasts well with the main content area (often card color, but might need a slight shade difference for border/contrast if the main background is also white/card color).
    // Using theme.cardColor for the background and theme.dividerColor for border/text shade.
    final Color placeholderColor = theme.colorScheme.onSurface
        .withOpacity(0.05); // A light shade for the placeholder background
    final Color iconColor = theme.colorScheme
        .primary; // Use primary color for the icon if it's not provided via asset
    final Color textColor =
        theme.textTheme.bodyMedium!.color!.withOpacity(0.6); // Muted text color

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: placeholderColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: 1,
              duration: const Duration(milliseconds: 300),
              child: Image.asset(
                Assets.assetsIconsAddImageIcon,
                height: 48,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              LocaleKeys.courseThumbnail,
              textAlign: TextAlign.center,
              style: AppTextStyles(context).bold13.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  // Adjusted to receive context to access Hero and AspectRatio safely
  Widget _buildImageView(BuildContext context) {
    return Hero(
      tag: "coursePosterPreview",
      child: AspectRatio(
        aspectRatio: 1 / .95,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildImage(),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (coursePosterImage != null) {
      return Image.file(
        coursePosterImage!,
        key: ValueKey(coursePosterImage),
        fit: BoxFit.cover,
      );
    }
    return CustomCachedNetworkImage(
      imageUrl: coursePosterUrl!,
      key: ValueKey(coursePosterUrl),
      fit: BoxFit.cover,
    );
  }
}
