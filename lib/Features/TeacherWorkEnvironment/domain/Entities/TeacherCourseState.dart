// ignore_for_file: file_names

import 'package:sintir/Core/utils/Backend_EndPoints.dart';

enum TeacherCourseState {
  published,
  inReview,
  declined,
  archived,
  hiddenByAdmin,
  removedByAdmin,
  unknown;

  static TeacherCourseState fromRaw(String? raw) {
    final value = raw?.trim().toLowerCase();
    if (value == null || value.isEmpty) return unknown;
    bool matches(String state) => value == state.toLowerCase();
    if (matches(BackendEndpoints.coursePublishedState)) return published;
    if (matches(BackendEndpoints.coursePendingState)) return inReview;
    if (matches(BackendEndpoints.coursedeclinedState) ||
        matches(BackendEndpoints.courseRejectedLegacyState)) {
      return declined;
    }
    if (matches(BackendEndpoints.courseDeletedState)) return archived;
    if (matches(BackendEndpoints.courseHiddenByAdminState)) {
      return hiddenByAdmin;
    }
    if (matches(BackendEndpoints.courseDeletedByAdminState)) {
      return removedByAdmin;
    }
    return unknown;
  }

  bool get isLive =>
      this == published || this == archived || this == hiddenByAdmin;

  bool get isBlockedByAdmin =>
      this == declined || this == hiddenByAdmin || this == removedByAdmin;

  bool get canArchive => this == published;

  bool get canRestore => this == archived;
}
