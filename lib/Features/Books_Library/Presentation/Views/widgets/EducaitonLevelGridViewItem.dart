import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Educaitonlevelgridviewitem extends StatelessWidget {
  const Educaitonlevelgridviewitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                Assets.assetsImagesEducationLevelSectionBooks,
              ),
              fit: BoxFit.cover),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: .5),
        ),
        child: Container(
          height: 30,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Text(
            "الصف الثالث الأبتدائى",
            style: AppTextStyles.semiBold14.copyWith(color: Colors.black),
          ),
        ));
  }
}
