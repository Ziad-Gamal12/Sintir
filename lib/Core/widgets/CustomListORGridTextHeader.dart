// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomListORGridTextHeader extends StatelessWidget {
  CustomListORGridTextHeader({
    super.key,
    required this.text,
    this.position,
    this.trailing,
    this.subtitle,
  });
  final String text;
  MainAxisAlignment? position;
  Widget? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = theme.textTheme.headlineSmall!.color!;
    final title = Text(
      text,
      style: AppTextStyles(context).semiBold20.copyWith(color: textColor),
    );
    final subtitleText = subtitle;

    return Row(
      mainAxisAlignment: position ?? MainAxisAlignment.start,
      children: [
        if (subtitleText == null) ...[
          title,
          const Spacer(),
        ] else
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                title,
                Text(
                  subtitleText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context).regular13.copyWith(
                    color: textColor.withValues(alpha: .64),
                  ),
                ),
              ],
            ),
          ),
        trailing != null ? trailing! : const SizedBox(),
      ],
    );
  }
}
