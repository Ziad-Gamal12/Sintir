import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/ChangeLanguageBottomSheet/ChangeLanguageBottomSheetView.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/CustomSettingsActionButton.dart';
import 'package:sintir/locale_keys.dart';

class CustomSettingsLanguageActionButton extends StatelessWidget {
  const CustomSettingsLanguageActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSettingsActionButton(
      title: LocaleKeys.language,
      iconData: Icons.language,
      onTap: () {
        showCustomBottomSheet(
            child: const ChangeLanguageBottomSheetView(), context: context);
      },
    );
  }
}
