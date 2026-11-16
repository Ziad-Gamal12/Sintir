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
    ReportType.incorrectInfo => Icons.info_outline_rounded,
    ReportType.other => Icons.more_horiz_rounded,
  };

  Color color(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return switch (this) {
      ReportType.inappropriateContent =>
        isDark ? const Color(0xFFEF4444) : const Color(0xFFD32F2F),
      ReportType.misleadingInfo => KSecondaryColor,
      ReportType.incorrectInfo => KMainColor,
      ReportType.other =>
        isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
    };
  }
}
