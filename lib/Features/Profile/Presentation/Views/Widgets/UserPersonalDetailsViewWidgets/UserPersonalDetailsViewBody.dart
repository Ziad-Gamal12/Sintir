import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/user_basic_info.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/user_contact_info.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/user_student_info.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/user_teacher_info.dart';
import 'package:sintir/constant.dart';

class UserPersonalDetailsViewBody extends StatefulWidget {
  const UserPersonalDetailsViewBody({super.key});

  @override
  State<UserPersonalDetailsViewBody> createState() =>
      _UserPersonalDetailsViewBodyState();
}

class _UserPersonalDetailsViewBodyState
    extends State<UserPersonalDetailsViewBody> {
  UserEntity user = getUserData();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: ListView(
        children: [
          UserBasicInfo(user: user),
          const SizedBox(height: 16),
          UserContactInfo(user: user),
          const SizedBox(height: 16),
          if (user.role == BackendEndpoints.teacherRole &&
              user.teacherExtraDataEntity != null)
            UserTeacherInfo(teacher: user.teacherExtraDataEntity!),
          if (user.role == BackendEndpoints.studentRole &&
              user.studentExtraDataEntity != null)
            UserStudentInfo(student: user.studentExtraDataEntity!),
        ],
      ),
    );
  }
}
