import 'report_enums.dart';

class CourseReportsItemEntity {
  final String id;
  final DateTime date;
  final ReportType type;
  final String description;
  final ReportStatus status;
  final String reporterId;
  final DateTime? resolvedAt;

  const CourseReportsItemEntity({
    required this.id,
    required this.date,
    required this.type,
    required this.description,
    this.status = ReportStatus.open,
    this.reporterId = '',
    this.resolvedAt,
  });

  static CourseReportsItemEntity empty() => CourseReportsItemEntity(
        id: '',
        date: DateTime.fromMillisecondsSinceEpoch(0),
        type: ReportType.other,
        description: '',
      );

  CourseReportsItemEntity copyWith({
    String? id,
    DateTime? date,
    ReportType? type,
    String? description,
    ReportStatus? status,
    String? reporterId,
    DateTime? resolvedAt,
    bool clearResolvedAt = false,
  }) =>
      CourseReportsItemEntity(
        id: id ?? this.id,
        date: date ?? this.date,
        type: type ?? this.type,
        description: description ?? this.description,
        status: status ?? this.status,
        reporterId: reporterId ?? this.reporterId,
        resolvedAt: clearResolvedAt ? null : (resolvedAt ?? this.resolvedAt),
      );

  @override
  bool operator ==(Object other) =>
      other is CourseReportsItemEntity &&
      other.id == id &&
      other.date == date &&
      other.type == type &&
      other.description == description &&
      other.status == status &&
      other.reporterId == reporterId &&
      other.resolvedAt == resolvedAt;

  @override
  int get hashCode =>
      Object.hash(id, date, type, description, status, reporterId, resolvedAt);
}
