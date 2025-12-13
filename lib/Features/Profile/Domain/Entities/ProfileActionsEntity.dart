import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/MyCoursesView.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/MyMistakesView.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/MyResultsView.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/MyTransactionsView.dart';
import 'package:sintir/Features/Profile/Presentation/Views/AboutUsView.dart';
import 'package:sintir/Features/Profile/Presentation/Views/SettingsView.dart';
import 'package:sintir/Features/Profile/Presentation/Views/UserPersonalDetailsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ProfileActionsEntity {
  final String title;
  final IconData icon;
  final String routeName;
  final Color? color;

  ProfileActionsEntity({
    required this.title,
    required this.icon,
    required this.routeName,
    this.color,
  });

  static List<ProfileActionsEntity> userCoreActions = [
    ProfileActionsEntity(
      title: LocaleKeys.profilePersonalData,
      icon: FontAwesomeIcons.user,
      routeName: UserPersonalDetailsView.routeName,
      color: KMainColor,
    ),
    ProfileActionsEntity(
      title: LocaleKeys.profileMyCourses,
      icon: FontAwesomeIcons.graduationCap,
      routeName: MyCoursesView.routeName,
      color: KSecondaryColor,
    ),
    ProfileActionsEntity(
      title: LocaleKeys.profileFavorites,
      icon: FontAwesomeIcons.solidHeart,
      routeName: Favoritesview.routeName,
      color: Colors.pink,
    ),
    ProfileActionsEntity(
      title: LocaleKeys.profileResults,
      icon: FontAwesomeIcons.chartColumn,
      routeName: MyResultsView.routeName,
      color: Colors.deepPurple,
    ),
    ProfileActionsEntity(
      title: LocaleKeys.profileMistakes,
      icon: FontAwesomeIcons.circleExclamation,
      routeName: MyMistakesView.routeName,
      color: Colors.red,
    ),
    ProfileActionsEntity(
      title: LocaleKeys.myPayments,
      icon: FontAwesomeIcons.wallet,
      routeName: MyTransactionsView.routeName,
      color: Colors.orange,
    ),
  ];

  static List<ProfileActionsEntity> studentActions = [...userCoreActions];
  static List<ProfileActionsEntity> teacherActions = [
    ProfileActionsEntity(
      routeName: TeacherWorkenvironmentview.routeName,
      title: LocaleKeys.workEnvironment,
      icon: FontAwesomeIcons.briefcase,
      color: Colors.green,
    ),
    ...userCoreActions
  ];

  static List<ProfileActionsEntity> appCoreActions = [
    ProfileActionsEntity(
      title: LocaleKeys.profileSettings,
      icon: FontAwesomeIcons.gear,
      routeName: SettingsView.routeName,
    ),
    ProfileActionsEntity(
      title: LocaleKeys.profileAbout,
      icon: FontAwesomeIcons.circleInfo,
      routeName: AboutUsView.routeName,
    ),
  ];

  Color getColor(BuildContext context) {
    return color ?? Theme.of(context).colorScheme.primary;
  }
}
