import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// "Academic wallet" title with the payout provider subtitle.
class TeacherWalletTitleBlock extends StatelessWidget {
  const TeacherWalletTitleBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.academicWalletTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textStyles.bold16.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          LocaleKeys.walletSubtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textStyles.regular12.copyWith(color: tokens.mutedText),
        ),
      ],
    );
  }
}
