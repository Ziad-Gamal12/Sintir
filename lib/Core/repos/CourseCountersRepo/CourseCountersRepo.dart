// ignore_for_file: file_names

import 'package:sintir/Core/Enums/courseCounterField.dart';

abstract class CourseCountersRepo {
  Future<void> updateCourseCounters({
    required String courseId,
    required String teacherId,
    required CourseCounterField field,
    required int delta,
  });
  Future<void> updateMultipleCourseCounters({
    required String courseId,
    required String teacherId,
    required Map<CourseCounterField, int> deltas,
  });
}
