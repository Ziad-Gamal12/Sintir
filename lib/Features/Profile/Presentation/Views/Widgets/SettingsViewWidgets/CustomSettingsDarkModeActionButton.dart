import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Themes/theme_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/CustomSettingsActionButton.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CustomSettingsDarkModeActionButton extends StatefulWidget {
  const CustomSettingsDarkModeActionButton({
    super.key,
  });

  @override
  State<CustomSettingsDarkModeActionButton> createState() =>
      _CustomSettingsDarkModeActionButtonState();
}

class _CustomSettingsDarkModeActionButtonState
    extends State<CustomSettingsDarkModeActionButton> {
  bool isDark = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isDark = Theme.of(context).brightness == Brightness.dark;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return CustomSettingsActionButton(
      title: LocaleKeys.darkMode,
      trailing: Switch(
          activeTrackColor:
              isDarkMode == false ? Colors.grey[800] : Colors.grey[450],
          activeThumbColor: KMainColor,
          inactiveTrackColor:
              isDarkMode ? Colors.grey[800] : Colors.grey.shade100,
          inactiveThumbColor: isDarkMode ? Colors.grey : Colors.black,
          value: isDark,
          onChanged: (val) async {
            context.read<ThemeCubit>().toggleTheme();
            setState(() {
              isDark = val;
            });
          }),
    );
  }
}
