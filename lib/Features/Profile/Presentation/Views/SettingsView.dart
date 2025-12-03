import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/SettingsViewBody.dart';
import 'package:sintir/locale_keys.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.profileSettings),
      body: const SettingsViewBody(),
    );
  }
}
