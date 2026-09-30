import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

extension ReportTypeUi on ReportType {
  String get label => switch (this) {
        ReportType.inappropriateContent => LocaleKeys.reportInappropriate,
        ReportType.misleadingInfo => LocaleKeys.reportMisleading,
        ReportType.incorrectInfo => LocaleKeys.reportWrongInfo,
        ReportType.other => LocaleKeys.reportOther,
      };
  IconData get icon => switch (this) {
        ReportType.inappropriateContent => Icons.flag_outlined,
        ReportType.misleadingInfo => Icons.warning_amber_rounded,
        ReportType.incorrectInfo => Icons.info_outline,
        ReportType.other => Icons.more_horiz,
      };
  Color color(BuildContext context) => switch (this) {
        ReportType.inappropriateContent => Theme.of(context).colorScheme.error,
        ReportType.misleadingInfo => KSecondaryColor,
        ReportType.incorrectInfo => KMainColor,
        ReportType.other => Theme.of(context).colorScheme.onSurfaceVariant,
      };
}
