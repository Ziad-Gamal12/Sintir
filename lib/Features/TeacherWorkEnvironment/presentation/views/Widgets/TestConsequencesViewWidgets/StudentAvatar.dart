import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:svg_flutter/svg.dart';

class StudentAvatar extends StatelessWidget {
  const StudentAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(Assets.assetsImagesUserAvatar);
  }
}
