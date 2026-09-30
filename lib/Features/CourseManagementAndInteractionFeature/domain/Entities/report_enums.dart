enum ReportType {
  inappropriateContent('inappropriate_content'),
  misleadingInfo('misleading_info'),
  incorrectInfo('incorrect_info'),
  other('other');

  const ReportType(this.key);
  final String key;
  static ReportType fromKey(String? value) => ReportType.values
      .firstWhere((type) => type.key == value, orElse: () => ReportType.other);
  static ReportType fromLegacyLabel(String? value) => switch (value) {
        'محتوى غير لائق' => ReportType.inappropriateContent,
        'عنوان أو وصف مضلل' => ReportType.misleadingInfo,
        'معلومات خاطئة' => ReportType.incorrectInfo,
        _ => ReportType.other,
      };
}

enum ReportStatus {
  open('open'),
  resolved('resolved'),
  dismissed('dismissed');

  const ReportStatus(this.key);
  final String key;
  static ReportStatus fromKey(String? value) =>
      ReportStatus.values.firstWhere((status) => status.key == value,
          orElse: () => ReportStatus.open);
}

enum ReportSortOrder { newestFirst, oldestFirst }
