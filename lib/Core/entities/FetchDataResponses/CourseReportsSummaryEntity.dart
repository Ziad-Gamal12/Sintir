import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';

class CourseReportsSummaryEntity {
  final int total;
  final int open;
  final int resolved;
  final int dismissed;

  const CourseReportsSummaryEntity({
    this.total = 0,
    this.open = 0,
    this.resolved = 0,
    this.dismissed = 0,
  });

  CourseReportsSummaryEntity copyWith(
          {int? total, int? open, int? resolved, int? dismissed}) =>
      CourseReportsSummaryEntity(
          total: total ?? this.total,
          open: open ?? this.open,
          resolved: resolved ?? this.resolved,
          dismissed: dismissed ?? this.dismissed);

  CourseReportsSummaryEntity moved(ReportStatus from, ReportStatus to) {
    if (from == to) return this;
    return copyWith(
      open: (open -
              (from == ReportStatus.open ? 1 : 0) +
              (to == ReportStatus.open ? 1 : 0))
          .clamp(0, total)
          .toInt(),
      resolved: (resolved -
              (from == ReportStatus.resolved ? 1 : 0) +
              (to == ReportStatus.resolved ? 1 : 0))
          .clamp(0, total)
          .toInt(),
      dismissed: (dismissed -
              (from == ReportStatus.dismissed ? 1 : 0) +
              (to == ReportStatus.dismissed ? 1 : 0))
          .clamp(0, total)
          .toInt(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is CourseReportsSummaryEntity &&
      other.total == total &&
      other.open == open &&
      other.resolved == resolved &&
      other.dismissed == dismissed;
  @override
  int get hashCode => Object.hash(total, open, resolved, dismissed);
}
