// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ScreenErrorwidget extends StatelessWidget {
  ScreenErrorwidget({super.key, this.errMessage});
  String? errMessage;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.assetsImagesErrorIcon,
          height: 200,
          width: 200,
        ),
        errMessage != null
            ? Text(errMessage!,
                textAlign: TextAlign.center,
                style:
                    AppTextStyles(context).bold32.copyWith(color: Colors.black))
            : const SizedBox()
      ],
    );
  }
}
