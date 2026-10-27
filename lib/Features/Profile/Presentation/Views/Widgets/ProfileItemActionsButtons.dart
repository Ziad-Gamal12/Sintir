import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileActionsGroupCard.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/TeacherWorkEnvironmentCard.dart';
import 'package:sintir/locale_keys.dart';

class ProfileItemActionsButtons extends StatelessWidget {
  const ProfileItemActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isTeacher = getUserData().role == BackendEndpoints.teacherRole;

    return Column(
      children: [
        if (isTeacher) ...[
          const TeacherWorkEnvironmentCard(),
          const SizedBox(height: 20),
        ],
        ProfileActionsGroupCard(
          sectionTitle: LocaleKeys.accountAndActivity,
          items: ProfileActionsEntity.userCoreActions,
        ),
        ProfileActionsGroupCard(
          sectionTitle: LocaleKeys.settingsAndSupport,
          items: ProfileActionsEntity.appCoreActions,
          topSpacing: 24,
        ),
      ],
    );
  }
}
