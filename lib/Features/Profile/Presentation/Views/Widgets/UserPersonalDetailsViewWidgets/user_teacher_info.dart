import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherExtraDataEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/CustomUserInfoItem.dart';

class UserTeacherInfo extends StatelessWidget {
  final TeacherExtraDataEntity teacher;

  const UserTeacherInfo({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "بيانات المعلم",
              style: styles.bold19.copyWith(color: Colors.black),
            ),

            const SizedBox(height: 16),

            // Subject
            CustomUserInfoItem(
              icon: FontAwesomeIcons.bookOpen,
              title: "المادة",
              value: teacher.subject,
            ),

            const SizedBox(height: 8),

            // Work Experience
            CustomUserInfoItem(
              icon: FontAwesomeIcons.briefcase,
              title: "الخبرة",
              value: " ${teacher.workExperience}",
            ),
          ],
        ),
      ),
    );
  }
}
