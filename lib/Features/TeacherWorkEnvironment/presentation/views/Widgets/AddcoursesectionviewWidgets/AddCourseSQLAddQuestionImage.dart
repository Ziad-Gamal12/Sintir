import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';

class Addcoursesqladdquestionimage extends StatelessWidget {
  const Addcoursesqladdquestionimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, left: 27, right: 27, bottom: 29),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        Assets.assetsImagesAddImageIcon,
        height: 50,
        width: 50,
      ),
    );
  }
}
