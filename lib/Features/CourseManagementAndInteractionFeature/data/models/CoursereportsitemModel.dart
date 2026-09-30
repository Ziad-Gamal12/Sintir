import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';

class CoursereportsitemModel {
  final String id;
  final DateTime date;
  final ReportType type;
  final String description;
  final ReportStatus status;
  final String reporterId;
  final DateTime? resolvedAt;

  const CoursereportsitemModel(
      {required this.id,
      required this.date,
      required this.type,
      required this.description,
      this.status = ReportStatus.open,
      this.reporterId = '',
      this.resolvedAt});

  factory CoursereportsitemModel.fromJson(Map<String, dynamic> json,
      {String id = ''}) {
    final rawType = json['type'] as String?;
    final parsedType = ReportType.fromKey(rawType);
    return CoursereportsitemModel(
      id: id,
      date: _date(json['date']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      type: rawType == null || parsedType == ReportType.other
          ? ReportType.fromLegacyLabel(rawType)
          : parsedType,
      description: json['description'] as String? ?? '',
      status: ReportStatus.fromKey(json['status'] as String?),
      reporterId: json['reporterId'] as String? ?? '',
      resolvedAt: _date(json['resolvedAt']),
    );
  }

  static DateTime? _date(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  factory CoursereportsitemModel.fromEntity(CourseReportsItemEntity entity) =>
      CoursereportsitemModel(
        id: entity.id,
        date: entity.date,
        type: entity.type,
        description: entity.description,
        status: entity.status,
        reporterId: entity.reporterId,
        resolvedAt: entity.resolvedAt,
      );

  CourseReportsItemEntity toEntity() => CourseReportsItemEntity(
        id: id,
        date: date,
        type: type,
        description: description,
        status: status,
        reporterId: reporterId,
        resolvedAt: resolvedAt,
      );

  Map<String, dynamic> toJson() => {
        'date': Timestamp.fromDate(date),
        'type': type.key,
        'description': description.trim(),
        'status': status.key,
        'reporterId': reporterId,
        'resolvedAt':
            resolvedAt == null ? null : Timestamp.fromDate(resolvedAt!),
      };
}
