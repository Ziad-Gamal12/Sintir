import 'package:sintir/Core/utils/imageAssets.dart';

class LocalizationEntity {
  final String languageCode;
  final String title;
  final String svgIcon;

  LocalizationEntity(
      {required this.svgIcon, required this.languageCode, required this.title});

  static List<LocalizationEntity> toList() {
    return [
      LocalizationEntity(
          svgIcon: Assets.assetsIconsSVGIconsEgyptFlag,
          languageCode: 'ar',
          title: 'العربية'),
      LocalizationEntity(
          svgIcon: Assets.assetsIconsSVGIconsUSAFlag,
          languageCode: 'en',
          title: 'English'),
      LocalizationEntity(
          svgIcon: Assets.assetsIconsSVGIconsFranceFlage,
          languageCode: "fr",
          title: "Français"),
    ];
  }
}
