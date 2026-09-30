import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseReportsSummaryEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_date_formatter.dart';

void main() {
  group('course reports helpers', () {
    test('maps legacy Arabic report types to stable keys', () {
      expect(ReportType.fromLegacyLabel('محتوى غير لائق'),
          ReportType.inappropriateContent);
      expect(
          ReportType.fromLegacyLabel('unrecognized value'), ReportType.other);
    });
    test('moves summary counts between statuses without changing total', () {
      const summary = CourseReportsSummaryEntity(
          total: 14, open: 5, resolved: 8, dismissed: 1);
      expect(
          summary.moved(ReportStatus.open, ReportStatus.resolved),
          const CourseReportsSummaryEntity(
              total: 14, open: 4, resolved: 9, dismissed: 1));
      expect(summary.moved(ReportStatus.open, ReportStatus.open), summary);
    });
    test('formats relative times and falls back to a date after 30 days', () {
      final now = DateTime(2026, 9, 29, 12);
      String translate(String key, {Map<String, String>? args}) =>
          args == null ? key : '$key:${args['count']}';
      expect(
          ReportDateFormatter.relativeTime(
              now.subtract(const Duration(minutes: 2)), now, 'en', translate),
          'report_time_minute_two');
      expect(
          ReportDateFormatter.relativeTime(
              now.subtract(const Duration(days: 4)), now, 'ar', translate),
          'report_time_day_few:4');
      expect(
          ReportDateFormatter.relativeTime(
              now.subtract(const Duration(days: 30)), now, 'en', translate),
          isNull);
    });
  });
}
