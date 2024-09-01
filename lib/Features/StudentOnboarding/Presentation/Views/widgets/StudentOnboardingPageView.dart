// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomOnboardingPageViewItem.dart';
import 'package:sintir/constant.dart';

class StudentOnboardingPageView extends StatelessWidget {
  const StudentOnboardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: [
        CustomOnboardingPageViewItem(
          description:
              "اكتشف عالماً جديداً من المعرفة والتعليم مع تطبيقنا. استعد لتجربة تعليمية تفاعلية وشاملة.",
          image: Assets.assetsImagesStudentOnboardingone,
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
              " خصص تجربتك التعليمية مع توصياتنا الشخصية. اعثر على الدروس والمقالات والموارد التي تتناسب مع اهتماماتك ومستوى تعليمك.",
          image: Assets.assetsImagesStudentOnboardingTwo,
          title: Text(" تعلم بسهولة وأمان",
              style: AppTextStyles.bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
        CustomOnboardingPageViewItem(
          description:
              "ابدأ رحلتك التعليمية مع سنتر. انضم الآن واكتشف كيف يمكن لتعليمك أن يصبح أكثر تفاعلاً وإثارة. اختر مسارك وابدأ التعلم اليوم!",
          image: Assets.assetsImagesStudentOnboardingThree,
          title: Text("ابدأ رحلتك التعليمية",
              style: AppTextStyles.bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
      ],
    );
  }
}
