import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(Assets.assetsImagesEmptyBox),
          const SizedBox(
            height: 10,
          ),
          Text(
            "المحتوى فارغ",
            style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
