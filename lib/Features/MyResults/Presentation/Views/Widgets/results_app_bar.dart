import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResultsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: ResultsTokens.of(theme).page,
      surfaceTintColor: ResultsTokens.of(theme).page,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        tooltip: LocaleKeys.resultsBack,
        icon: const BackButtonIcon(),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(LocaleKeys.myResultsAppbar,
          style: AppTextStyles(context)
              .semiBold20
              .copyWith(color: theme.colorScheme.onSurface)),
    );
  }
}
