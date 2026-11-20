import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomEducationLevelDropdownButton.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfileEducationalLevelField extends StatelessWidget {
  const CompleteProfileEducationalLevelField({
    super.key,
    required this.theme,
    required this.vallueChanged,
  });

  final ThemeData theme;
  final ValueChanged<String?> vallueChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.completeProfileEducationLevel,
          style: AppTextStyles(
            context,
          ).semiBold12.copyWith(color: theme.textTheme.bodyMedium?.color),
        ),
        SizedBox(height: 6),
        CustomEducationLevelDropdownButton(onValueChange: vallueChanged),
        SizedBox(height: 6),
        Text(
          LocaleKeys.completeProfileEducationLevelHint,
          style: AppTextStyles(context).regular11,
        ),
      ],
    );
  }
}
