import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/Profile/Presentation/Views/DeleteAccountView.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/CustomSettingsActionButton.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/CustomSettingsDarkModeActionButton.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/CustomSettingsLanguageActionButton.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: ListView(
        children: [
          const CustomSettingsLanguageActionButton(),
          const SizedBox(
            height: 12,
          ),
          const CustomSettingsDarkModeActionButton(),
          const SizedBox(
            height: 12,
          ),
          CustomSettingsActionButton(
            key: const ValueKey('settings-delete-account'),
            title: LocaleKeys.accountDeleteTitle,
            leadingIcon: Icons.delete_forever_outlined,
            onTap: () =>
                GoRouter.of(context).push(DeleteAccountView.routeName),
          ),
        ],
      ),
    );
  }
}
