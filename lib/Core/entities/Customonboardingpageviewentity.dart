// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class Customonboardingpageviewentity {
  final String image;
  final Widget title;
  final String description;

  Customonboardingpageviewentity(
      {required this.image, required this.title, required this.description});

  static List<Customonboardingpageviewentity> studentToList(
          BuildContext context) =>
      [
        Customonboardingpageviewentity(
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
          image: Assets.assetsImagesStudentOnboardingone,
          description:
              "اكتشف عالماً جديداً من المعرفة والتعليم مع تطبيقنا. استعد لتجربة تعليمية تفاعلية وشاملة.",
        ),
        Customonboardingpageviewentity(
          title: Text(" تعلم بسهولة وأمان",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
          image: Assets.assetsImagesStudentOnboardingTwo,
          description:
              " خصص تجربتك التعليمية مع توصياتنا الشخصية. اعثر على الدروس والمقالات والموارد التي تتناسب مع اهتماماتك ومستوى تعليمك.",
        ),
        Customonboardingpageviewentity(
          description:
              "ابدأ رحلتك التعليمية مع سنتر. انضم الآن واكتشف كيف يمكن لتعليمك أن يصبح أكثر تفاعلاً وإثارة. اختر مسارك وابدأ التعلم اليوم!",
          image: Assets.assetsImagesStudentOnboardingThree,
          title: Text("ابدأ رحلتك التعليمية",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
      ];

  static List<Customonboardingpageviewentity> teacherToList(
          BuildContext context) =>
      [
        Customonboardingpageviewentity(
          description:
              "استعد لاستكشاف مجموعة من الأدوات المصممة لدعم تجربتك العلمية",
          image: Assets.assetsImagesTeacherOnboarding1,
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
        Customonboardingpageviewentity(
          description:
              "من خطط الدروس الديناميكية إلى التعليقات الفورية، اكتشف الميزات التي ستساعدك على جذب وتحفيز طلابك.",
          image: Assets.assetsImagesTeacherOnboarding2,
          title: Text("تفاعل مع طلابك",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
        Customonboardingpageviewentity(
          description:
              "ابدأ رحلتك الآن وارتبط بشبكة من المعلمين. دعنا نعمل معًا لإحداث فرق في التعليم!",
          image: Assets.assetsImagesTeacherOnboarding3,
          title: Text("ابدأ اليوم",
              style: AppTextStyles(context)
                  .bold23
                  .copyWith(color: const Color(0xff000000))),
        ),
      ];
}
