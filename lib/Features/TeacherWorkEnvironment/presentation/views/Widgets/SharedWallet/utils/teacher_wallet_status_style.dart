import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// Label, colors and icon for each wallet status, shared by every place that
/// shows it (card pill, details row, withdraw lock) so they always agree.
extension TeacherWalletStatusStyle on TeacherWalletStatus {
  String get label => switch (this) {
    TeacherWalletStatus.active => LocaleKeys.statusActive,
    TeacherWalletStatus.suspended => LocaleKeys.walletStatusSuspended,
    TeacherWalletStatus.inactive => LocaleKeys.walletStatusInactive,
  };

  Color foreground(WorkEnvironmentThemeExtension tokens) => switch (this) {
    TeacherWalletStatus.active => tokens.successForeground,
    TeacherWalletStatus.suspended => tokens.warningForeground,
    TeacherWalletStatus.inactive => tokens.dangerForeground,
  };

  Color background(WorkEnvironmentThemeExtension tokens) => switch (this) {
    TeacherWalletStatus.active => tokens.successBackground,
    TeacherWalletStatus.suspended => tokens.warningBackground,
    TeacherWalletStatus.inactive => tokens.dangerBackground,
  };

  Color border(WorkEnvironmentThemeExtension tokens) => switch (this) {
    TeacherWalletStatus.active => tokens.successBorder,
    TeacherWalletStatus.suspended => tokens.warningBorder,
    TeacherWalletStatus.inactive => tokens.dangerBorder,
  };

  /// Icon for "you can't withdraw" messaging.
  IconData get lockIcon => switch (this) {
    TeacherWalletStatus.suspended => Icons.pause_circle_outline_rounded,
    _ => Icons.lock_outline_rounded,
  };
}
