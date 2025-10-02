// ignore_for_file: file_names

import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/views/AiTeacherView.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';

class DrawerEntity {
  final String title;
  final String activeIcon, inActiveIcon;
  final String routeName;

  DrawerEntity(
      {required this.title,
      required this.activeIcon,
      required this.inActiveIcon,
      required this.routeName});
  static List<DrawerEntity> toList() {
    return [
      DrawerEntity(
          title: "الرئيسية",
          activeIcon: Assets.assetsIconsActiveHomeIcon,
          inActiveIcon: Assets.assetsIconsInActiveHomeIcon,
          routeName: Homeview.routeName),
      DrawerEntity(
          title: "كورساتي",
          activeIcon: Assets.assetsIconsDrawerMycourses,
          inActiveIcon: Assets.assetsIconsDrawerMycourses,
          routeName: ""),
      DrawerEntity(
          title: "البحث",
          activeIcon: Assets.assetsIconsSearch,
          inActiveIcon: Assets.assetsIconsSearch,
          routeName: ""),
      DrawerEntity(
          title: "المنتدى",
          activeIcon: Assets.assetsIconsDrawerStudentsClub,
          inActiveIcon: Assets.assetsIconsDrawerStudentsClub,
          routeName: ""),
      DrawerEntity(
          title: "المساعد الألي",
          activeIcon: Assets.assetsIconsActiveAiChatIcon,
          inActiveIcon: Assets.assetsIconsInActiveAiChatIcon,
          routeName: AiTeacherview.routeName),
      DrawerEntity(
          title: "المفضله",
          activeIcon: Assets.assetsIconsActiveFavouriteIcon,
          inActiveIcon: Assets.assetsIconsInActiveFavouriteIcon,
          routeName: Favoritesview.routeName),
    ];
  }
}
