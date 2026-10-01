import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/locale_keys.dart';

class ReportReasonCardEntity {
  final String title;
  final String description;
  final ReportType type;
  final IconData icon;
  final Color color;

  ReportReasonCardEntity(
      {required this.title,
      required this.description,
      required this.type,
      required this.icon,
      required this.color});
  static List<ReportReasonCardEntity> getReportReasonCardEntities() {
    return [
      ReportReasonCardEntity(
        title: LocaleKeys.reportInappropriate,
        description: LocaleKeys.reportInappropriateDescription,
        type: ReportType.inappropriateContent,
        icon: Icons.block,
        color: Color(0xffEF4444),
      ),
      ReportReasonCardEntity(
        title: LocaleKeys.reportMisleading,
        description: LocaleKeys.reportMisleadingDescription,
        type: ReportType.misleadingInfo,
        icon: Icons.warning,
        color: Color(0xffFF8C1A),
      ),
      ReportReasonCardEntity(
        title: LocaleKeys.reportWrongInfo,
        description: LocaleKeys.reportWrongInfoDescription,
        type: ReportType.incorrectInfo,
        icon: Icons.error,
        color: Color(0xff214FC8),
      ),
      ReportReasonCardEntity(
        title: LocaleKeys.reportOther,
        description: LocaleKeys.reportOtherDescription,
        type: ReportType.other,
        icon: Icons.help_outline,
        color: Color(0xff434654),
      ),
    ];
  }
}
