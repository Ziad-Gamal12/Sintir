// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CustomOnBoardingPageViewEntity {
  final String image;
  final Widget title;
  final String description;

  CustomOnBoardingPageViewEntity(
      {required this.image, required this.title, required this.description});

  static List<CustomOnBoardingPageViewEntity> studentToList(
          BuildContext context) =>
      [
        CustomOnBoardingPageViewEntity(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" مرحبًا بك في ",
                  style: AppTextStyles(context)
                      .bold23
                      .copyWith(color: const Color(0xff000000))),
              Text("SINTIR",
                  style: AppTextStyles(context)
                      .bold23
                      .copyWith(color: KSecondaryColor)),
            ],
          ),
          image: Assets.assetsImagesSVGImagesStudentOnboardingone,
          description:
              "اكتشف عالماً جديداً من المعرفة والتعليم مع تطبيقنا. استعد لتجربة تعليمية تفاعلية وشاملة.",
        ),
        CustomOnBoardingPageViewEntity(
          title: Text(" تعلم بسهولة وأمان",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
          image: Assets.assetsImagesSVGImagesStudentOnboardingTwo,
          description:
              " خصص تجربتك التعليمية مع توصياتنا الشخصية. اعثر على الدروس والمقالات والموارد التي تتناسب مع اهتماماتك ومستوى تعليمك.",
        ),
        CustomOnBoardingPageViewEntity(
          description:
              "ابدأ رحلتك التعليمية مع سنتر. انضم الآن واكتشف كيف يمكن لتعليمك أن يصبح أكثر تفاعلاً وإثارة. اختر مسارك وابدأ التعلم اليوم!",
          image: Assets.assetsImagesSVGImagesStudentOnboardingThree,
          title: Text("ابدأ رحلتك التعليمية",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
      ];

  static List<CustomOnBoardingPageViewEntity> teacherToList(
          BuildContext context) =>
      [
        CustomOnBoardingPageViewEntity(
          description:
              "استعد لاستكشاف مجموعة من الأدوات المصممة لدعم تجربتك العلمية",
          image: Assets.assetsImagesSVGImagesTeacherOnboarding1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" مرحبًا بك في ",
                  style: AppTextStyles(context)
                      .bold23
                      .copyWith(color: const Color(0xff000000))),
              Text("SINTIR",
                  style: AppTextStyles(context)
                      .bold23
                      .copyWith(color: KSecondaryColor)),
            ],
          ),
        ),
        CustomOnBoardingPageViewEntity(
          description:
              "من خطط الدروس الديناميكية إلى التعليقات الفورية، اكتشف الميزات التي ستساعدك على جذب وتحفيز طلابك.",
          image: Assets.assetsImagesSVGImagesTeacherOnboarding2,
          title: Text("تفاعل مع طلابك",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
        CustomOnBoardingPageViewEntity(
          description:
              "ابدأ رحلتك الآن وارتبط بشبكة من المعلمين. دعنا نعمل معًا لإحداث فرق في التعليم!",
          image: Assets.assetsImagesSVGImagesTeacherOnboarding3,
          title: Text("ابدأ اليوم",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
      ];
}
