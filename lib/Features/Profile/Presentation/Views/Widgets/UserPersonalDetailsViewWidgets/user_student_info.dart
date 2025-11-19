import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/StudentExtraDataEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/CustomUserInfoItem.dart';

class UserStudentInfo extends StatelessWidget {
  final StudentExtraDataEntity student;

  const UserStudentInfo({super.key, required this.student});

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
              "بيانات الطالب",
              style: styles.bold19.copyWith(color: Colors.black),
            ),

            const SizedBox(height: 16),

            // Education Level
            CustomUserInfoItem(
              icon: FontAwesomeIcons.layerGroup,
              title: "المرحلة الدراسية",
              value: student.educationLevel,
            ),

            const SizedBox(height: 8),

            // Birth Date
            CustomUserInfoItem(
              icon: FontAwesomeIcons.cakeCandles,
              title: "تاريخ الميلاد",
              value: student.birthDate,
            ),
          ],
        ),
      ),
    );
  }
}
