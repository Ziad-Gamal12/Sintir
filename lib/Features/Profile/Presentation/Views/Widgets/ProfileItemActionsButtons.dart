import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileActionsGroupCard.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/TeacherWorkEnvironmentCard.dart';
import 'package:sintir/locale_keys.dart';

class ProfileItemActionsButtons extends StatelessWidget {
  const ProfileItemActionsButtons({super.key});

  static const double _twoColumnsMinWidth = 760;
  static const double _columnSpacing = 24;

  @override
  Widget build(BuildContext context) {
    final isTeacher = getUserData().role == BackendEndpoints.teacherRole;

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= _twoColumnsMinWidth;
        final accountGroup = ProfileActionsGroupCard(
          sectionTitle: LocaleKeys.accountAndActivity,
          items: ProfileActionsEntity.userCoreActions,
        );
        final settingsGroup = ProfileActionsGroupCard(
          sectionTitle: LocaleKeys.settingsAndSupport,
          items: ProfileActionsEntity.appCoreActions,
          topSpacing: twoColumns ? 0 : 24,
        );

        return Column(
          children: [
            if (isTeacher) ...[
              const TeacherWorkEnvironmentCard(),
              SizedBox(height: twoColumns ? _columnSpacing : 20),
            ],
            if (twoColumns)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: accountGroup),
                  const SizedBox(width: _columnSpacing),
                  Expanded(child: settingsGroup),
                ],
              )
            else ...[
              accountGroup,
              settingsGroup,
            ],
          ],
        );
      },
    );
  }
}
