import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherExtraDataEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/CustomUserInfoItem.dart';
import 'package:sintir/locale_keys.dart';

class UserTeacherInfo extends StatelessWidget {
  final TeacherExtraDataEntity teacher;

  const UserTeacherInfo({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color iconColor =
        theme.colorScheme.primary; // Consistent color for icons

    return Card(
      elevation: 4,
      color: cardColor, // Use theme card color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              LocaleKeys.teacherData,
              style: styles.semiBold20.copyWith(
                  color: primaryTextColor), // Use theme primary text color
            ),

            const SizedBox(height: 16),

            // Subject
            CustomUserInfoItem(
              icon: FontAwesomeIcons.bookOpen,
              iconColor: iconColor, // Pass theme color for consistency
              title: LocaleKeys.teacherSubject,
              value: teacher.subject,
            ),

            const SizedBox(height: 8),

            // Work Experience
            CustomUserInfoItem(
              icon: FontAwesomeIcons.briefcase,
              iconColor: iconColor, // Pass theme color for consistency
              title: LocaleKeys.experienceYears,
              value: " ${teacher.workExperience}",
            ),
          ],
        ),
      ),
    );
  }
}
