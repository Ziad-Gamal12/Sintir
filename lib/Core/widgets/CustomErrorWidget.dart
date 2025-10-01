import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errormessage});
  final String errormessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(Assets.assetsImagesError404,
            height: 70, width: 70, fit: BoxFit.fill),
        const SizedBox(
          height: 10,
        ),
        Text(errormessage,
            textAlign: TextAlign.center,
            style:
                AppTextStyles(context).semiBold16.copyWith(color: Colors.black))
      ],
    );
  }
}
