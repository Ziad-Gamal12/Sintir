import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/entities/BottomNavigationBar_Entity.dart';

class BottomnavigationbarModel {
  static List<BottomnavigationbarEntity> toList() {
    return [
      BottomnavigationbarEntity(
          title: "الرئيسية", icon: FontAwesomeIcons.house, index: 0),
      BottomnavigationbarEntity(
          title: "المهام", icon: FontAwesomeIcons.listCheck, index: 1),
      BottomnavigationbarEntity(
          title: "المساعد الألي", icon: FontAwesomeIcons.rocketchat, index: 2),
      BottomnavigationbarEntity(
          title: "المكتبه", icon: FontAwesomeIcons.book, index: 3),
      BottomnavigationbarEntity(
          title: "المفضله", icon: FontAwesomeIcons.bookmark, index: 4),
    ];
  }
}
