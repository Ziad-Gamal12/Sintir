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
    final Color iconColor = theme.colorScheme.primary;

    return Card(
      elevation: 4,
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.teacherData,
              style: styles.semiBold20.copyWith(color: primaryTextColor),
            ),
            const SizedBox(height: 16),
            CustomUserInfoItem(
              icon: FontAwesomeIcons.bookOpen,
              iconColor: iconColor,
              title: LocaleKeys.teacherSubject,
              value: teacher.subject,
            ),
            const SizedBox(height: 8),
            CustomUserInfoItem(
              icon: FontAwesomeIcons.briefcase,
              iconColor: iconColor,
              title: LocaleKeys.experienceYears,
              value: " ${teacher.workExperience}",
            ),
          ],
        ),
      ),
    );
  }
}
