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
    this.isPopUp = true,
    this.onBackPressed,
    this.backgroundColor,
  });
  final String appBartitle;
  final VoidCallback? onBackPressed;
  final bool? isPopUp;

  /// Defaults to the scaffold background of the current theme.
  final Color? backgroundColor;

  @override
  AppBar build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return AppBar(
      leadingWidth: 50,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      leading: isPopUp == true
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: onBackPressed ?? () => GoRouter.of(context).pop(),
                child: Transform.rotate(
                  angle: locale.languageCode == 'ar' ? 0 : 3.14,
                  child: SvgPicture.asset(
                    Assets.assetsIconsSVGIconsArrowLeftBack,
                    height: 20,
                    width: 20,
                    colorFilter: isDarkMode == true
                        ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : null,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      title: Text(
        appBartitle,
        style: AppTextStyles(context).bold19,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
