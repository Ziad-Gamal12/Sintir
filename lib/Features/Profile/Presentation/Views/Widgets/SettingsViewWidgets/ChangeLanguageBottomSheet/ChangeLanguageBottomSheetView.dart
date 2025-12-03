import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sintir/Core/Managers/Cubits/LocalizationCubit/LocaleCubit.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Profile/Domain/Entities/LocalizationEntity.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/SettingsViewWidgets/ChangeLanguageBottomSheet/LanguageItem.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ChangeLanguageBottomSheetView extends StatefulWidget {
  const ChangeLanguageBottomSheetView({super.key});

  @override
  State<ChangeLanguageBottomSheetView> createState() =>
      _ChangeLanguageBottomSheetViewState();
}

class _ChangeLanguageBottomSheetViewState
    extends State<ChangeLanguageBottomSheetView> {
  late String _stagedLanguageCode;

  @override
  void initState() {
    super.initState();
    _stagedLanguageCode = context.read<LocaleCubit>().state.languageCode;
  }

  void _saveLanguage(BuildContext context) {
    final LocalizationEntity newLocaleEntity =
        LocalizationEntity.toList().firstWhere(
      (e) => e.languageCode == _stagedLanguageCode,
      orElse: () => LocalizationEntity.toList().first,
    );

    context.read<LocaleCubit>().setLocale(newLocaleEntity);

    Navigator.pop(context);

    Future.microtask(() {
      Restart.restartApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final String currentAppliedLanguageCode =
        context.read<LocaleCubit>().state.languageCode;

    final bool isStagedLanguageDifferent =
        _stagedLanguageCode != currentAppliedLanguageCode;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: LocalizationEntity.toList()
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _stagedLanguageCode = e.languageCode;
                            });
                          },
                          child: LanguageItem(
                            isSelected: e.languageCode == _stagedLanguageCode,
                            locale: e,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          if (isStagedLanguageDifferent)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Custombutton(
                text: LocaleKeys.save,
                color: theme.colorScheme.secondary,
                textColor: theme.colorScheme.onSecondary,
                onPressed: () => _saveLanguage(context),
              )
                  .animate()
                  .fadeIn(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 200),
                  )
                  .moveY(
                    begin: 40,
                    duration: const Duration(milliseconds: 400),
                  ),
            ),
        ],
      ),
    );
  }
}
