import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/widgets/CustomPageViewItem.dart';

class Custompageview extends StatelessWidget {
  final PageController controller;
  const Custompageview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: [
        Custompageviewitem(
            image: Assets.assetsImagesChooseStudent,
            title: "طالب",
            description:
                "مرحبًا بك في عالم التعلم والمعرفة!,اكتشف المحتوى المثير وطور مهاراتك.نحن هنا لدعمك في رحلتك التعليمية.ابدأ مغامرتك التعليمية معنا الآن!",
            onPressed: () {}),
        Custompageviewitem(
            image: Assets.assetsImagesChooseTeacher,
            title: "معلم",
            description:
                "مرحبًا بك في منصة التعليم الخاصة بالمعلمين!,نحن هنا لمساعدتك في تحسين تجربة التعليم.,ابدأ بتطوير استراتيجيات تعليمية فعّالة ومبتكرة.,طور مهارات طلابك وكن جزءًا من نجاحهم.",
            onPressed: () {}),
      ],
    );
  }
}
