import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Addcourseposter extends StatelessWidget {
  const Addcourseposter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 20, left: 27, right: 27, bottom: 29),
        decoration: BoxDecoration(
          color: const Color(0xffF9FAFA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(Assets.assetsImagesAddImageIcon),
            const SizedBox(
              height: 20,
            ),
            Text(
              "الصورة المصغرة للدورة",
              style:
                  AppTextStyles.bold13.copyWith(color: const Color(0xffAEAEB2)),
            )
          ],
        ));
  }
}
