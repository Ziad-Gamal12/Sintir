// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';

/// The question image, whole (letterboxed) and at most [maxHeight] tall.
class CustomReviewQuestionImage extends StatelessWidget {
  const CustomReviewQuestionImage({super.key, required this.imageFile});

  final File? imageFile;

  static const double maxHeight = 240;

  @override
  Widget build(BuildContext context) {
    final file = imageFile;
    if (file == null) return const SizedBox.shrink();

    final tokens = WorkEnvironmentThemeExtension.of(context);
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: maxHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: ColoredBox(
          color: tokens.neutralBackground,
          child: LayoutBuilder(
            builder: (context, constraints) => Image.file(
              file,
              width: double.infinity,
              fit: BoxFit.contain,
              cacheWidth: constraints.maxWidth.isFinite
                  ? (constraints.maxWidth * dpr).round()
                  : null,
              errorBuilder: (context, error, stackTrace) => SizedBox(
                height: 96,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: tokens.mutedText,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
