// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeViewBodyAppBar extends StatelessWidget {
  const HomeViewBodyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: SvgPicture.asset(Assets.assetsImagesUserAvatar),
      ),
      title: Text.rich(TextSpan(children: [
        TextSpan(
          text: "مرحبا بعودتك , ",
          style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
        ),
        TextSpan(
          text: "زياد",
          style: AppTextStyles.bold20Auto.copyWith(color: KSecondaryColor),
        ),
      ])),
      trailing: Image.asset(
        Assets.assetsImagesNotificationIcon,
        height: 32,
        width: 32,
      ),
    );
  }
}
