import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileActionsEntity {
  final String title;
  final IconData icon;

  ProfileActionsEntity({required this.title, required this.icon});

  static List<ProfileActionsEntity> commonActions = [
    ProfileActionsEntity(
      title: "البيانات الشخصية",
      icon: FontAwesomeIcons.user,
    ),
    ProfileActionsEntity(
      title: "كورساتي",
      icon: FontAwesomeIcons.graduationCap,
    ),
    ProfileActionsEntity(
      title: "المفضلة",
      icon: FontAwesomeIcons.solidHeart,
    ),
    ProfileActionsEntity(
      title: "نتائجي",
      icon: FontAwesomeIcons.chartColumn,
    ),
    ProfileActionsEntity(
      title: "أخطائي",
      icon: FontAwesomeIcons.circleExclamation,
    ),
    ProfileActionsEntity(
      title: "الإعدادات",
      icon: FontAwesomeIcons.gear,
    ),
    ProfileActionsEntity(
      title: "من نحن",
      icon: FontAwesomeIcons.circleInfo,
    ),
  ];

  static List<ProfileActionsEntity> studentActions = [...commonActions];
  static List<ProfileActionsEntity> teacherActions = [
    ProfileActionsEntity(title: "بيئة العمل", icon: FontAwesomeIcons.briefcase),
    ...commonActions
  ];
}
