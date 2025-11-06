import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/MyCoursesView.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/MyMistakesView.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/MyResultsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';

class ProfileActionsEntity {
  final String title;
  final IconData icon;
  final String routeName;

  ProfileActionsEntity(
      {required this.title, required this.icon, required this.routeName});

  static List<ProfileActionsEntity> commonActions = [
    ProfileActionsEntity(
      title: "البيانات الشخصية",
      icon: FontAwesomeIcons.user,
      routeName: "",
    ),
    ProfileActionsEntity(
      title: "كورساتي",
      icon: FontAwesomeIcons.graduationCap,
      routeName: MyCoursesView.routeName,
    ),
    ProfileActionsEntity(
      title: "المفضلة",
      icon: FontAwesomeIcons.solidHeart,
      routeName: "",
    ),
    ProfileActionsEntity(
      title: "نتائجي",
      icon: FontAwesomeIcons.chartColumn,
      routeName: MyResultsView.routeName,
    ),
    ProfileActionsEntity(
      title: "أخطائي",
      icon: FontAwesomeIcons.circleExclamation,
      routeName: MyMistakesView.routeName,
    ),
    ProfileActionsEntity(
      title: "الإعدادات",
      icon: FontAwesomeIcons.gear,
      routeName: "",
    ),
    ProfileActionsEntity(
      title: "من نحن",
      icon: FontAwesomeIcons.circleInfo,
      routeName: "",
    ),
  ];

  static List<ProfileActionsEntity> studentActions = [...commonActions];
  static List<ProfileActionsEntity> teacherActions = [
    ProfileActionsEntity(
        routeName: TeacherWorkenvironmentview.routeName,
        title: "بيئة العمل",
        icon: FontAwesomeIcons.briefcase),
    ...commonActions
  ];
}
