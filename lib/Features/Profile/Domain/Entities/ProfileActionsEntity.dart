import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/MyCoursesView.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/MyMistakesView.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/MyResultsView.dart';
import 'package:sintir/Features/Profile/Presentation/Views/UserPersonalDetailsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';
import 'package:sintir/constant.dart';

class ProfileActionsEntity {
  final String title;
  final IconData icon;
  final String routeName;
  Color? color;

  ProfileActionsEntity(
      {this.color,
      required this.title,
      required this.icon,
      required this.routeName});

  static List<ProfileActionsEntity> userCoreActions = [
    ProfileActionsEntity(
        title: "البيانات الشخصية",
        icon: FontAwesomeIcons.user,
        routeName: UserPersonalDetailsView.routeName,
        color: KMainColor),
    ProfileActionsEntity(
        title: "كورساتي",
        icon: FontAwesomeIcons.graduationCap,
        routeName: MyCoursesView.routeName,
        color: KSecondaryColor),
    ProfileActionsEntity(
      title: "المفضلة",
      icon: FontAwesomeIcons.solidHeart,
      routeName: Favoritesview.routeName,
      color: Colors.pink,
    ),
    ProfileActionsEntity(
        title: "نتائجي",
        icon: FontAwesomeIcons.chartColumn,
        routeName: MyResultsView.routeName,
        color: Colors.deepPurple),
    ProfileActionsEntity(
      title: "أخطائي",
      icon: FontAwesomeIcons.circleExclamation,
      routeName: MyMistakesView.routeName,
      color: Colors.red,
    ),
  ];

  static List<ProfileActionsEntity> studentActions = [...userCoreActions];
  static List<ProfileActionsEntity> teacherActions = [
    ProfileActionsEntity(
        routeName: TeacherWorkenvironmentview.routeName,
        title: "بيئة العمل",
        icon: FontAwesomeIcons.briefcase,
        color: Colors.green),
    ...userCoreActions
  ];
  static List<ProfileActionsEntity> appCoreActions = [
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
    ProfileActionsEntity(
      title: "الدعم",
      icon: FontAwesomeIcons.circleQuestion,
      routeName: "",
    ),
  ];
}
