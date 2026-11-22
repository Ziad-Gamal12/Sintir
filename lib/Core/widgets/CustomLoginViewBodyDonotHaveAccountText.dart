// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomLoginViewBodyDonotHaveAccountText extends StatelessWidget {
  const CustomLoginViewBodyDonotHaveAccountText({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final link = BrandPalette.of(context).link;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: link,
        minimumSize: const Size(64, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(
        LocaleKeys.createAccount,
        style: AppTextStyles(context).bold16.copyWith(color: link),
      ),
    );
  }
}
