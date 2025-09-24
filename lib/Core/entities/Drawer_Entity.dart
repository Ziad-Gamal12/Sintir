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
          activeIcon: Assets.assetsImagesActiveHomeIcon,
          inActiveIcon: Assets.assetsImagesInActiveHomeIcon,
          routeName: Homeview.routeName),
      DrawerEntity(
          title: "كورساتي",
          activeIcon: Assets.assetsImagesDrawerMycourses,
          inActiveIcon: Assets.assetsImagesDrawerMycourses,
          routeName: ""),
      DrawerEntity(
          title: "البحث",
          activeIcon: Assets.assetsImagesSearch,
          inActiveIcon: Assets.assetsImagesSearch,
          routeName: ""),
      DrawerEntity(
          title: "المنتدى",
          activeIcon: Assets.assetsImagesDrawerStudentsClub,
          inActiveIcon: Assets.assetsImagesDrawerStudentsClub,
          routeName: ""),
      DrawerEntity(
          title: "المساعد الألي",
          activeIcon: Assets.assetsImagesInActiveAiChatIcon,
          inActiveIcon: Assets.assetsImagesInActiveAiChatIcon,
          routeName: AiTeacherview.routeName),
      DrawerEntity(
          title: "المفضله",
          activeIcon: Assets.assetsImagesActiveFavouriteIcon,
          inActiveIcon: Assets.assetsImagesInActiveFavouriteIcon,
          routeName: Favoritesview.routeName),
    ];
  }
}
