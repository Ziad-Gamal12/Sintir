import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Profile/Domain/Entities/ProfileActionsEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileItemAction.dart';

class ProfileItemActionsButtons extends StatefulWidget {
  const ProfileItemActionsButtons({super.key});

  @override
  State<ProfileItemActionsButtons> createState() =>
      _ProfileItemActionsButtonsState();
}

class _ProfileItemActionsButtonsState extends State<ProfileItemActionsButtons> {
  String role = getUserData().role;
  List<ProfileActionsEntity> actions() {
    if (role == BackendEndpoints.teacherRole) {
      return ProfileActionsEntity.teacherActions;
    } else {
      return ProfileActionsEntity.studentActions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...actions().map((e) => ProfileItemAction(profileActionsEntity: e)),
        Divider(
          color: Colors.grey.shade300,
          height: 40,
        ),
        ...ProfileActionsEntity.appCoreActions
            .map((e) => ProfileItemAction(profileActionsEntity: e)),
      ],
    );
  }
}
