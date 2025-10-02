// ignore_for_file: must_be_immutable, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';

class CustomReviewQuestionImage extends StatelessWidget {
  CustomReviewQuestionImage({
    super.key,
    required this.imageFile,
  });
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: imageFile == null
          ? Image.asset(Assets.assetsIconsAddImageIcon)
          : Image.file(imageFile!),
    );
  }
}
