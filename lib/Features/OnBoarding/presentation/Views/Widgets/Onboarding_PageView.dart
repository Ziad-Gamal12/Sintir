import 'package:flutter/material.dart';
import 'package:sintir/Core/Utils/imageAssets.dart';
import 'package:sintir/Core/Utils/textStyles.dart';
import 'package:sintir/Features/OnBoarding/presentation/Views/Widgets/Onboarding_PageView_item.dart';
import 'package:sintir/constant.dart';

class OnboardingPageview extends StatelessWidget {
  final PageController controller;

  const OnboardingPageview({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return PageView(controller: controller, children: [
      OnboardingPageviewItem(
          svgPicture: Assets.assetsImagesOnboardingWelcome,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "مرحبًا بك في",
                style: textStyles.textstyle23.copyWith(color: KMainColor),
              ),
              Text(
                " سنتر!",
                style: textStyles.textstyle23.copyWith(color: KSecondColor),
              )
            ],
          ),
          description: ".مرحبًا بك في تطبيق سنتر! رحلتك نحو المعرفة تبدأ هنا"),
      OnboardingPageviewItem(
          svgPicture: Assets.assetsImagesOnboardingPlaylist,
          title: Text(
            "اكتشف الميزات الرائعة",
            style: textStyles.textstyle23.copyWith(color: KMainColor),
          ),
          description:
              "استمتع بتجربة تعلم تفاعلية وسهلة الاستخدام لجميع المستويات."),
      OnboardingPageviewItem(
          title: Text(
            "تعليم شخصي",
            style: textStyles.textstyle23.copyWith(color: KMainColor),
          ),
          svgPicture: Assets.assetsImagesOnboardingpersonalGoals,
          description:
              "استمتع بمحتوى تعليمي مصمم خصيصًا ليناسب أسلوبك واحتياجاتك التعليمية."),
      OnboardingPageviewItem(
          svgPicture: Assets.assetsImagesOnboardingGetStarted,
          title: Text(
            "ابدأ الان",
            style: textStyles.textstyle23.copyWith(color: KMainColor),
          ),
          description: "جاهز لاكتشاف عالم من المعرفة؟ اضغط على ابدأ للانطلاق.")
    ]);
  }
}
