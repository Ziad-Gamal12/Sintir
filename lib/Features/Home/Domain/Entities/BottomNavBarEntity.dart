// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarEntity {
  final String title;
  final IconData icon;

  BottomNavBarEntity({
    required this.title,
    required this.icon,
  });
  static List<BottomNavBarEntity> toList() {
    return [
      BottomNavBarEntity(
        title: "الرئيسية",
        icon: FontAwesomeIcons.house,
      ),
      BottomNavBarEntity(
        title: "البحث",
        icon: FontAwesomeIcons.magnifyingGlass,
      ),
      BottomNavBarEntity(
        title: "المساعد الآلي",
        icon: FontAwesomeIcons.robot,
      ),
      BottomNavBarEntity(
        title: "المفضلة",
        icon: FontAwesomeIcons.solidHeart,
      ),
      BottomNavBarEntity(
        title: "حسابي",
        icon: FontAwesomeIcons.user,
      ),
    ];
  }
}
