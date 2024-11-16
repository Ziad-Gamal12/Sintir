import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/entities/BottomNavigationBar_Entity.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/tasks/presentation/views/todoListView.dart';

class BottomnavigationbarModel {
  static List<BottomnavigationbarEntity> toList() {
    return [
      BottomnavigationbarEntity(
          title: "الرئيسية",
          icon: FontAwesomeIcons.house,
          routeName: Homeview.routeName),
      BottomnavigationbarEntity(
          title: "المهام",
          icon: FontAwesomeIcons.listCheck,
          routeName: Todolistview.routeName),
      BottomnavigationbarEntity(
          title: "المساعد الألي",
          icon: FontAwesomeIcons.rocketchat,
          routeName: ""),
      BottomnavigationbarEntity(
          title: "المكتبه", icon: FontAwesomeIcons.book, routeName: ""),
      BottomnavigationbarEntity(
          title: "المفضله", icon: FontAwesomeIcons.bookmark, routeName: ""),
    ];
  }
}
