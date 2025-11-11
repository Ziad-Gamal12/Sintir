// ignore_for_file: file_names

import 'package:sintir/Core/utils/imageAssets.dart';

class BottomNavBarEntity {
  final String title;
  final String activeIcon, inactiveIcon;

  BottomNavBarEntity({
    required this.title,
    required this.activeIcon,
    required this.inactiveIcon,
  });
  static List<BottomNavBarEntity> toList() {
    return [
      BottomNavBarEntity(
        title: "الرئيسية",
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarHomeActiveIcon,
        inactiveIcon: Assets.assetsIconsSVGIconsBottomNavBarHomeInActiveIcon,
      ),
      BottomNavBarEntity(
        title: "البحث",
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarSearchActiveIcon,
        inactiveIcon: Assets.assetsIconsSVGIconsBottomNavBarSearchInActiveIcon,
      ),
      BottomNavBarEntity(
        title: "المفضلة",
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarFavouriteActiveIcon,
        inactiveIcon:
            Assets.assetsIconsSVGIconsBottomNavBarFavouriteInActiveIcon,
      ),
      BottomNavBarEntity(
        title: "حسابي",
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarProfileActiveIcon,
        inactiveIcon: Assets.assetsIconsSVGIconsBottomNavBarProfileInActiveIcon,
      ),
    ];
  }
}
