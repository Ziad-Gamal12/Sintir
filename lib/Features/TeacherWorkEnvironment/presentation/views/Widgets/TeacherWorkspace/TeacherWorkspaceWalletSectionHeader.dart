// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWalletDetailsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkenvironmentviewBodyWalletSectionHeader
    extends StatelessWidget {
  const TeacherWorkenvironmentviewBodyWalletSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);

    return Semantics(
      header: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              LocaleKeys.wallet,
              style: textStyles.bold20.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              GoRouter.of(context).push(TeacherWalletDetailsView.routeName);
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 4,
                vertical: 6,
              ),
              child: Text(
                LocaleKeys.viewDetails,
                style: textStyles.regular13.copyWith(color: tokens.mutedText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
