// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/locale_keys.dart';

class CustomOnBoardingPageViewEntity {
  final String image;
  final Widget title;
  final String description;

  CustomOnBoardingPageViewEntity(
      {required this.image, required this.title, required this.description});

  static Widget _welcomeTitle(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Flexible(child: Text(LocaleKeys.welcomeTo)),
          Text(
            'Sintir',
            textDirection: TextDirection.ltr,
            style: TextStyle(color: BrandPalette.of(context).accent),
          ),
        ],
      );

  static List<CustomOnBoardingPageViewEntity> studentToList(
          BuildContext context) =>
      [
        CustomOnBoardingPageViewEntity(
            title: _welcomeTitle(context),
            image: Assets.assetsImagesSVGImagesStudentOnboardingone,
            description: LocaleKeys.description1),
        CustomOnBoardingPageViewEntity(
          title: Text(LocaleKeys.learnEasySafe),
          image: Assets.assetsImagesSVGImagesStudentOnboardingTwo,
          description: LocaleKeys.description2,
        ),
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.description3,
          image: Assets.assetsImagesSVGImagesStudentOnboardingThree,
          title: Text(LocaleKeys.startLearningJourneyTitle),
        ),
      ];

  static List<CustomOnBoardingPageViewEntity> teacherToList(
          BuildContext context) =>
      [
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.teacherToolsDescription,
          image: Assets.assetsImagesSVGImagesTeacherOnboarding1,
          title: _welcomeTitle(context),
        ),
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.teacherFeaturesDescription,
          image: Assets.assetsImagesSVGImagesTeacherOnboarding2,
          title: Text(LocaleKeys.teacherFeaturesTitle),
        ),
        CustomOnBoardingPageViewEntity(
          description: LocaleKeys.teacherStartTodayDescription,
          image: Assets.assetsImagesSVGImagesTeacherOnboarding3,
          title: Text(LocaleKeys.teacherStartTodayTitle),
        ),
      ];
}
