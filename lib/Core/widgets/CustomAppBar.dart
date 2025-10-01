// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg_flutter.dart';

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
      elevation: 0,
      scrolledUnderElevation: 0,
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
        style: AppTextStyles(context).bold19.copyWith(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
