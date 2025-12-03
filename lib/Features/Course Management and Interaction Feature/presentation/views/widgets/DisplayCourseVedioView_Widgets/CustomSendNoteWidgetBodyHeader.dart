import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomSendNoteWidgetBodyHeader extends StatelessWidget {
  const CustomSendNoteWidgetBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.primaryColor.withOpacity(.1),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.question_mark_rounded,
            color: theme.iconTheme.color,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          LocaleKeys.sendNote,
          style: AppTextStyles(context).semiBold20.copyWith(
                color: theme.textTheme.titleLarge?.color,
              ),
        ),
      ],
    );
  }
}
