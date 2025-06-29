import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

class StudentAvatarWithProgress extends StatelessWidget {
  const StudentAvatarWithProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(Assets.assetsImagesUserAvatar),
        const Positioned.fill(
          child: CircularProgressIndicator(
            color: KMainColor,
            strokeWidth: 5,
            value: 0.9,
          ),
        ),
      ],
    );
  }
}
