// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomOnboardingPageViewItem.dart';
import 'package:sintir/constant.dart';

class TeacherOnboardingPageView extends StatelessWidget {
  const TeacherOnboardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: [
        CustomOnboardingPageViewItem(
          description:
              "استعد لاستكشاف مجموعة من الأدوات المصممة لدعم تجربتك العلمية",
          image: Assets.assetsImagesTeacherOnboarding1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" مرحبًا بك في ",
                  style: AppTextStyles.bold23
                      .copyWith(color: const Color(0xff000000))),
              Text("Sintir",
                  style: AppTextStyles.bold23.copyWith(color: KSecondaryColor)),
            ],
          ),
        ),
        CustomOnboardingPageViewItem(
          description:
              "من خطط الدروس الديناميكية إلى التعليقات الفورية، اكتشف الميزات التي ستساعدك على جذب وتحفيز طلابك.",
          image: Assets.assetsImagesTeacherOnboarding2,
          title: Text("تفاعل مع طلابك",
              style: AppTextStyles.bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
        CustomOnboardingPageViewItem(
          description:
              "ابدأ رحلتك الآن وارتبط بشبكة من المعلمين. دعنا نعمل معًا لإحداث فرق في التعليم!",
          image: Assets.assetsImagesTeacherOnboarding3,
          title: Text("ابدأ اليوم",
              style: AppTextStyles.bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
      ],
    );
  }
}
