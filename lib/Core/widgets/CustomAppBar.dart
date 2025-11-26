// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.appBartitle, this.isPopUp = true});
  final String appBartitle;
  bool? isPopUp;

  @override
  AppBar build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    return AppBar(
      leadingWidth: 40,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: isPopUp == true
          ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: Transform.rotate(
                  angle: locale.languageCode == 'ar' ? 0 : 3.14,
                  child: SvgPicture.asset(
                    Assets.assetsIconsSVGIconsArrowLeftBack,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
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
