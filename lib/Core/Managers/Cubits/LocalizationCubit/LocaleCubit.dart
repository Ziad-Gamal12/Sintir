// locale_cubit.dart
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sintir/Features/Profile/Domain/Entities/LocalizationEntity.dart';

// The state will be the Locale object itself
class LocaleCubit extends HydratedCubit<Locale> {
  LocaleCubit() : super(const Locale('ar'));

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
  ];

  void setLocale(LocalizationEntity newLocaleEntity) {
    final newLocale = Locale(newLocaleEntity.languageCode);
    emit(newLocale);
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    // Deserialize the stored language code back into a Locale object
    final String? languageCode = json['languageCode'] as String?;
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(Locale state) {
    return {'languageCode': state.languageCode};
  }
}
