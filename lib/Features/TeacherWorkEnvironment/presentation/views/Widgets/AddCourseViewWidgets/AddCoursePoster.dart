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
      child: _hasImage ? _buildImageView() : _buildPlaceholder(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xffF9FAFA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
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
              ),
            ),
            const SizedBox(height: 22),
            Text(
              LocaleKeys.courseThumbnail,
              textAlign: TextAlign.center,
              style: AppTextStyles(context)
                  .bold13
                  .copyWith(color: const Color(0xffAEAEB2)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageView() {
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
