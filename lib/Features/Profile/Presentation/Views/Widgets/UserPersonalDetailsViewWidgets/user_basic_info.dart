import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/CustomUserInfoItem.dart';

class UserBasicInfo extends StatelessWidget {
  final UserEntity user;

  const UserBasicInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name
            Text(
              user.fullName,
              style: styles.semiBold20.copyWith(color: Colors.black),
            ),

            const SizedBox(height: 16),

            // Email
            CustomUserInfoItem(
              icon: FontAwesomeIcons.solidEnvelope,
              title: "البريد الإلكتروني",
              value: user.email,
            ),

            const SizedBox(height: 8),

            // Gender
            CustomUserInfoItem(
              icon: FontAwesomeIcons.venusMars,
              title: "النوع",
              value: user.gender,
            ),

            const SizedBox(height: 8),

            // Role
            CustomUserInfoItem(
              icon: FontAwesomeIcons.userTag,
              title: "الصلاحية",
              value: user.role,
            ),

            const SizedBox(height: 8),

            // Joined Date
            CustomUserInfoItem(
              icon: FontAwesomeIcons.calendarCheck,
              title: "تاريخ التسجيل",
              value: user.joinedDate,
            ),
          ],
        ),
      ),
    );
  }
}
