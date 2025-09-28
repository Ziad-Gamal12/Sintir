import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserAvatar.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.user,
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(imageUrl: user.profilePicurl),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserName(firstName: user.firstName, lastName: user.lastName),
            if (user.studentExtraDataEntity != null)
              Column(
                children: [
                  Text(user.studentExtraDataEntity!.educationLevel,
                      style: AppTextStyles.semiBold16
                          .copyWith(color: Colors.black)),
                  Text(user.studentExtraDataEntity!.birthDate,
                      style: AppTextStyles.semiBold16
                          .copyWith(color: Colors.black)),
                ],
              )
            else if (user.teacherExtraDataEntity != null)
              Column(
                children: [
                  Text("مادة ${user.teacherExtraDataEntity!.subject}",
                      style: AppTextStyles.semiBold16
                          .copyWith(color: Colors.black)),
                  Text(
                      "خبره ${user.teacherExtraDataEntity!.workExperience} سنه",
                      style: AppTextStyles.semiBold16
                          .copyWith(color: Colors.black)),
                ],
              )
            else
              const SizedBox(),
            const SizedBox(height: 10),
            _UserStatusBadge(status: user.status),
          ],
        ),
      ],
    );
  }
}

class _UserName extends StatelessWidget {
  final String firstName;
  final String lastName;
  const _UserName({required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$firstName $lastName",
      style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
    );
  }
}

class _UserRole extends StatelessWidget {
  final String role;
  const _UserRole({required this.role});

  @override
  Widget build(BuildContext context) {
    return Text(
      roleText(role),
      style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
    );
  }
}

class _UserStatusBadge extends StatelessWidget {
  final String status;
  const _UserStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: statusBadgeColor(status),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        statusBadgeText(status),
        style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
      ),
    );
  }
}

Color statusBadgeColor(String status) {
  if (status == BackendEndpoints.activeStatus) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

String statusBadgeText(String status) {
  if (status == BackendEndpoints.activeStatus) {
    return "مفعل";
  } else if (status == BackendEndpoints.inActiveStatus) {
    return "غير مفعل";
  } else if (status == BackendEndpoints.blockedStatus) {
    return "محظور";
  } else if (status == BackendEndpoints.pendingStatus) {
    return "قيد الانتظار";
  } else {
    return "غير معروف";
  }
}

String roleText(String role) {
  if (role == BackendEndpoints.studentRole) {
    return "طالب";
  } else if (role == BackendEndpoints.teacherRole) {
    return "معلم";
  } else {
    return "غير معروف";
  }
}
