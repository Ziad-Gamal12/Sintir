import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/CustomSettingsDarkModeActionButton.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/CustomSettingsLanguageActionButton.dart';
import 'package:sintir/constant.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: ListView(
        children: const [
          CustomSettingsLanguageActionButton(),
          SizedBox(
            height: 12,
          ),
          CustomSettingsDarkModeActionButton()
        ],
      ),
    );
  }
}
