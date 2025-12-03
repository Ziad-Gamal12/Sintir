import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/StudentExtraDataEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/CustomUserInfoItem.dart';
import 'package:sintir/locale_keys.dart';

class UserStudentInfo extends StatelessWidget {
  final StudentExtraDataEntity student;

  const UserStudentInfo({super.key, required this.student});

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
              LocaleKeys.studentData,
              style: styles.semiBold20.copyWith(
                  color: primaryTextColor), // Use theme primary text color
            ),

            const SizedBox(height: 16),

            // Education Level
            CustomUserInfoItem(
              icon: FontAwesomeIcons.layerGroup,
              iconColor: iconColor, // Pass theme color for consistency
              title: LocaleKeys.studentEducationLevel,
              value: student.educationLevel,
            ),

            const SizedBox(height: 8),

            // Birth Date
            CustomUserInfoItem(
              icon: FontAwesomeIcons.cakeCandles,
              iconColor: iconColor, // Pass theme color for consistency
              title: LocaleKeys.studentBirthDate,
              value: student.birthDate,
            ),
          ],
        ),
      ),
    );
  }
}
