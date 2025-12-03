import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/CustomUserInfoItem.dart';
import 'package:sintir/locale_keys.dart';

class UserBasicInfo extends StatelessWidget {
  final UserEntity user;

  const UserBasicInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color iconColor =
        theme.colorScheme.primary; // A distinct color for icons/emphasis

    return Card(
      elevation: 4,
      color: cardColor, // Use theme card color
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
              style: styles.semiBold20.copyWith(
                  color: primaryTextColor), // Use theme primary text color
            ),

            const SizedBox(height: 16),

            // Email
            CustomUserInfoItem(
              icon: FontAwesomeIcons.solidEnvelope,
              title: LocaleKeys.profileEmail,
              value: user.email,
            ),

            // Gender
            CustomUserInfoItem(
              icon: FontAwesomeIcons.venusMars,
              title: LocaleKeys.profileGender,
              value: user.gender,
            ),

            const SizedBox(height: 8),

            // Role
            CustomUserInfoItem(
              icon: FontAwesomeIcons.userTag,
              title: LocaleKeys.profileRole,
              value: user.role,
            ),

            const SizedBox(height: 8),

            // Joined Date
            CustomUserInfoItem(
              icon: FontAwesomeIcons.calendarCheck,
              title: LocaleKeys.profileJoinedDate,
              value: user.joinedDate,
            ),
          ],
        ),
      ),
    );
  }
}
