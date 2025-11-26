// ignore_for_file: file_names

import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/locale_keys.dart';

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
        title: LocaleKeys.home,
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarHomeActiveIcon,
        inactiveIcon: Assets.assetsIconsSVGIconsBottomNavBarHomeInActiveIcon,
      ),
      BottomNavBarEntity(
        title: LocaleKeys.search,
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarSearchActiveIcon,
        inactiveIcon: Assets.assetsIconsSVGIconsBottomNavBarSearchInActiveIcon,
      ),
      BottomNavBarEntity(
        title: LocaleKeys.favorites,
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarFavouriteActiveIcon,
        inactiveIcon:
            Assets.assetsIconsSVGIconsBottomNavBarFavouriteInActiveIcon,
      ),
      BottomNavBarEntity(
        title: LocaleKeys.profile,
        activeIcon: Assets.assetsIconsSVGIconsBottomNavBarProfileActiveIcon,
        inactiveIcon: Assets.assetsIconsSVGIconsBottomNavBarProfileInActiveIcon,
      ),
    ];
  }
}
