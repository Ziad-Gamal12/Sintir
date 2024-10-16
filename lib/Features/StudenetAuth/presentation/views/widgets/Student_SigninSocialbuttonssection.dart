import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/customStudentSocialButton.dart';

class Student_SigninSocialbuttonssection extends StatelessWidget {
  const Student_SigninSocialbuttonssection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Customstudentsocialbutton(
          text: "تسجيل بواسطة جوجل",
          onPressed: () {},
          iconpath: Assets.assetsImagesGoogle,
        ),
        const Customsizedbox(width: 0, height: 16),
        Customstudentsocialbutton(
          text: "تسجيل بواسطة فيسبوك",
          onPressed: () {},
          iconpath: Assets.assetsImagesFaceBookIcons,
        ),
        const Customsizedbox(width: 0, height: 16),
        Customstudentsocialbutton(
          text: "تسجيل بواسطة أبل",
          onPressed: () {},
          iconpath: Assets.assetsImagesApple,
        ),
      ],
    );
  }
}
