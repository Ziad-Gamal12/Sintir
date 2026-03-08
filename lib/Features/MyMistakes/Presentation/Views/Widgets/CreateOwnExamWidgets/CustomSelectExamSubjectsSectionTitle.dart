import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomSelectExamSubjectsSectionTitle extends StatelessWidget {
  const CustomSelectExamSubjectsSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
      LocaleKeys.selectSubjectTitle,
      style: AppTextStyles(context)
          .semiBold20
          .copyWith(color: theme.textTheme.bodyLarge?.color),
    );
  }
}
