import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CreateOwnExamViewHeadLine extends StatelessWidget {
  const CreateOwnExamViewHeadLine({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.viewHeadline,
          style: AppTextStyles(context)
              .semiBold24
              .copyWith(color: theme.textTheme.headlineSmall?.color),
        ),
        const SizedBox(height: 4),
        Text(
          LocaleKeys.viewSubHeadline,
          style: AppTextStyles(context).regular14.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
