import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomEmptyWidget extends StatelessWidget {
  CustomEmptyWidget({
    super.key,
    this.text,
  });
  String? text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(Assets.assetsIconsEmptyBox),
          const SizedBox(
            height: 10,
          ),
          Text(
            text ?? "المحتوى فارغ",
            style:
                AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
