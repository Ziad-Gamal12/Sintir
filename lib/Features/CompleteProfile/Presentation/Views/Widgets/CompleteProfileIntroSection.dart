import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfileIntroSection extends StatelessWidget {
  const CompleteProfileIntroSection({
    super.key,
    required this.styles,
    required this.theme,
  });

  final AppTextStyles styles;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.completeProfileTitle,
          textAlign: TextAlign.start,
          style: styles.bold24.copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          LocaleKeys.completeProfileSubtitle,
          textAlign: TextAlign.start,
          style: styles.regular14,
        ),
      ],
    );
  }
}
