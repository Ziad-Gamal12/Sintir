import 'package:flutter/widgets.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseStatus.dart';
import 'package:sintir/locale_keys.dart';

/// Display-ready values for one course card, computed once per build so the
/// card's widgets only lay things out.
@immutable
class TeacherCourseCardData {
  const TeacherCourseCardData({
    required this.title,
    required this.posterUrl,
    required this.status,
    required this.statusLabel,
    required this.isFree,
    required this.priceLabel,
    required this.studentsLabel,
    required this.lessonsLabel,
    required this.testsLabel,
    required this.isNew,
  });

  /// A course counts as new for this long after it was posted.
  static const Duration newCourseWindow = Duration(days: 14);

  factory TeacherCourseCardData.fromCourse(
    BuildContext context,
    CourseEntity course, {
    DateTime? now,
  }) {
    final locale = Localizations.localeOf(context).languageCode;
    final status = TeacherCourseStatus.fromRaw(course.state);
    final posterUrl = course.posterUrl;
    final isFree = course.price == 0;
    final age = (now ?? DateTime.now()).difference(course.postedDate);

    return TeacherCourseCardData(
      isNew: !age.isNegative && age <= newCourseWindow,
      title: course.title,
      posterUrl: (posterUrl == null || posterUrl.isEmpty) ? null : posterUrl,
      status: status,
      statusLabel: status.label(context),
      isFree: isFree,
      priceLabel: isFree
          ? LocaleKeys.freeCourseLabel
          : '${TeacherWorkEnvironmentFormatters.formatPrice(course.price)} '
                '${LocaleKeys.currencyEgpSymbol}',
      studentsLabel: TeacherWorkEnvironmentFormatters.formatStudentsCount(
        course.studentsCount,
        locale,
      ),
      lessonsLabel: TeacherWorkEnvironmentFormatters.formatLessonsCount(
        course.lessonsCount,
        locale,
      ),
      testsLabel: TeacherWorkEnvironmentFormatters.formatTestsCount(
        course.testsCount,
        locale,
      ),
    );
  }

  final String title;
  final String? posterUrl;
  final TeacherCourseStatus status;
  final String statusLabel;
  final bool isFree;
  final String priceLabel;
  final String studentsLabel;
  final String lessonsLabel;
  final String testsLabel;

  /// Posted within [newCourseWindow]; shows the localized "New" chip.
  final bool isNew;

  bool get hasStatus => statusLabel.isNotEmpty;

  /// Footer line, e.g. "14 درس • 4 اختبارات".
  String get contentLabel => '$lessonsLabel • $testsLabel';

  String get semanticsLabel => [
    title,
    if (isNew) LocaleKeys.newCourseLabel,
    statusLabel,
    priceLabel,
    studentsLabel,
    lessonsLabel,
    testsLabel,
  ].where((part) => part.isNotEmpty).join(', ');
}
