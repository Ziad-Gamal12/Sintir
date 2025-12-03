// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

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
                Text(LocaleKeys.welcomeTo,
                    style: AppTextStyles(context).semiBold24),
                Text(" SINTIR ",
                    style: AppTextStyles(context)
                        .semiBold24
                        .copyWith(color: KSecondaryColor)),
              ],
            ),
            image: Assets.assetsImagesSVGImagesStudentOnboardingone,
            description: LocaleKeys.description1),
        CustomOnBoardingPageViewEntity(
          title: Text(LocaleKeys.learnEasySafe,
              style: AppTextStyles(context).semiBold24),
          image: Assets.assetsImagesSVGImagesStudentOnboardingTwo,
          description: LocaleKeys.description2,
        ),
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.description3,
          image: Assets.assetsImagesSVGImagesStudentOnboardingThree,
          title: Text(LocaleKeys.startLearningJourneyTitle,
              style: AppTextStyles(context).semiBold24),
        ),
      ];

  static List<CustomOnBoardingPageViewEntity> teacherToList(
          BuildContext context) =>
      [
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.teacherToolsDescription,
          image: Assets.assetsImagesSVGImagesTeacherOnboarding1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.welcomeTo,
                  style: AppTextStyles(context).semiBold24),
              Text(" SINTIR ",
                  style: AppTextStyles(context)
                      .semiBold24
                      .copyWith(color: KSecondaryColor)),
            ],
          ),
        ),
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.teacherFeaturesDescription,
          image: Assets.assetsImagesSVGImagesTeacherOnboarding2,
          title: Text(LocaleKeys.teacherFeaturesTitle,
              style: AppTextStyles(context).semiBold24),
        ),
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.teacherStartTodayDescription,
          image: Assets.assetsImagesSVGImagesTeacherOnboarding3,
          title: Text(LocaleKeys.teacherStartTodayTitle,
              style: AppTextStyles(context).semiBold24),
        ),
      ];
}
