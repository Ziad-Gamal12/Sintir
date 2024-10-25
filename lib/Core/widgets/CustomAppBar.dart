// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, required this.appBartitle});
  final String appBartitle;
  AppBar build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        child: SvgPicture.asset(Assets.assetsImagesArrowLeftBack),
      ),
      title: Text(
        appBartitle,
        style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
