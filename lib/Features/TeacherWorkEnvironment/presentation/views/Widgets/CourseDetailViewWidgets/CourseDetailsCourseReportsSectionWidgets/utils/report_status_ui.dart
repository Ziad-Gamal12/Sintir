import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

const Color reportResolvedLight = Color(0xff007A57);
const Color reportResolvedDark = Color(0xff47D7A3);

extension ReportStatusUi on ReportStatus {
  String get label => switch (this) {
        ReportStatus.open => LocaleKeys.reportOpen,
        ReportStatus.resolved => LocaleKeys.reportResolved,
        ReportStatus.dismissed => LocaleKeys.reportDismissed,
      };
  IconData get icon => switch (this) {
        ReportStatus.open => Icons.circle,
        ReportStatus.resolved => Icons.check_circle_outline,
        ReportStatus.dismissed => Icons.highlight_off,
      };
  Color color(BuildContext context) => switch (this) {
        ReportStatus.open => KSecondaryColor,
        ReportStatus.resolved => Theme.of(context).brightness == Brightness.dark
            ? reportResolvedDark
            : reportResolvedLight,
        ReportStatus.dismissed =>
          Theme.of(context).colorScheme.onSurfaceVariant,
      };
}
