import 'package:sintir/Core/entities/Drawer_Entity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/AI_Chat/presentation/views/aiChatView.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/EducationLevelsBooksSectionsView.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/tasks/presentation/views/TasksView.dart';

class DrawerModel {
  static List<DrawerEntity> toList() {
    return [
      DrawerEntity(
          title: "الرئيسية",
          activeIcon: Assets.assetsImagesActiveHomeIcon,
          inActiveIcon: Assets.assetsImagesInActiveHomeIcon,
          routeName: Homeview.routeName),
      DrawerEntity(
          title: "المهام",
          activeIcon: Assets.assetsImagesActiveTasksIcon,
          inActiveIcon: Assets.assetsImagesInActiveTasksIcon,
          routeName: TasksView.routeName),
      DrawerEntity(
          title: "المساعد الألي",
          activeIcon: Assets.assetsImagesInActiveAiChatIcon,
          inActiveIcon: Assets.assetsImagesInActiveAiChatIcon,
          routeName: Aichatview.routeName),
      DrawerEntity(
          title: "المكتبه",
          activeIcon: Assets.assetsImagesActiveLibraryIcon,
          inActiveIcon: Assets.assetsImagesInActiveLibraryIcon,
          routeName: EducationLevelsBooksSectionsView.routeName),
      DrawerEntity(
          title: "المفضله",
          activeIcon: Assets.assetsImagesActiveFavouriteIcon,
          inActiveIcon: Assets.assetsImagesInActiveFavouriteIcon,
          routeName: Favoritesview.routeName),
    ];
  }
}
