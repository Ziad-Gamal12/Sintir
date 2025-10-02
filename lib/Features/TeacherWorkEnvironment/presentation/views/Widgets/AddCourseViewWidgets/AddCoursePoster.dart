// ignore_for_file: must_be_immutable, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Addcourseposter extends StatelessWidget {
  Addcourseposter(
      {super.key,
      this.coursePosterImage,
      required this.onTap,
      this.coursePosterUrl});
  File? coursePosterImage;
  String? coursePosterUrl;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    if (coursePosterImage == null && coursePosterUrl == null) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 27, right: 27, bottom: 29),
          decoration: BoxDecoration(
            color: const Color(0xffF9FAFA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Image.asset(Assets.assetsIconsAddImageIcon),
              const SizedBox(
                height: 20,
              ),
              Text(
                "الصورة المصغرة للدورة",
                style: AppTextStyles(context)
                    .bold13
                    .copyWith(color: const Color(0xffAEAEB2)),
              )
            ],
          ),
        ),
      );
    } else if (coursePosterImage != null) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: AspectRatio(
          aspectRatio: 1 / .95,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              coursePosterImage!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (coursePosterImage == null && coursePosterUrl != null) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: AspectRatio(
          aspectRatio: 1 / .95,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              coursePosterUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
