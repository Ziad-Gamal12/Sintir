// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomFavouriteListHeader extends StatelessWidget {
  const CustomFavouriteListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.favorites,
          style: AppTextStyles(context).bold20.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
