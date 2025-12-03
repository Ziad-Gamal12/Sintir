// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSettingsActionButton extends StatelessWidget {
  CustomSettingsActionButton(
      {super.key,
      required this.title,
      this.trailing,
      this.iconData,
      this.onTap});
  final String title;
  Widget? trailing;
  IconData? iconData;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AspectRatio(
      aspectRatio: 6 / 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyles(context)
                    .semiBold16
                    .copyWith(color: isDark ? Colors.white : Colors.black),
              ),
              if (iconData != null && trailing == null)
                Icon(iconData,
                    color: isDark ? Colors.white : Colors.black, size: 35)
              else if (trailing != null && iconData == null)
                trailing!
              else
                const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
