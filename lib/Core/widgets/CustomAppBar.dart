// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.appBartitle,
  });
  final String appBartitle;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: SvgPicture.asset(
            Assets.assetsImagesArrowLeftBack,
            height: 20,
            width: 20,
          ),
        ),
      ),
      title: Text(
        appBartitle,
        style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
