// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/models/contentCreaterModel.dart';

class Coursemodel {
  final String id, posterUrl, title, description, language, state;
  final int price;
  final int studentsCount, lessonsCount, testsCount, feedBacksCount;
  final String subject;
  final String level;
  final DateTime postedDate;
  final Map contentcreaterentity;

  /// Read-only here: written by the course feedback Edge Functions.
  final CourseRatingStatsEntity ratingStats;

  /// Written by the dashboard when a reviewer declines the course.
  final String? declineReason;
  final DateTime? declinedAt;
  final DateTime? resubmittedAt;

  Coursemodel({
    required this.id,
    required this.posterUrl,
    required this.studentsCount,
    required this.title,
    required this.description,
    required this.price,
    required this.language,
    required this.lessonsCount,
    required this.testsCount,
    required this.feedBacksCount,
    required this.subject,
    required this.level,
    required this.state,
    required this.postedDate,
    required this.contentcreaterentity,
    this.ratingStats = const CourseRatingStatsEntity(),
    this.declineReason,
    this.declinedAt,
    this.resubmittedAt,
  });

  static DateTime? dateOrNull(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static String? reasonOrNull(Object? value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  factory Coursemodel.fromEntity({required CourseEntity courseEntity}) {
    return Coursemodel(
      id: courseEntity.id,
      posterUrl: courseEntity.posterUrl ?? "",
      subject: courseEntity.subject,
      level: courseEntity.level,
      title: courseEntity.title,
      description: courseEntity.description,
      price: courseEntity.price,
      lessonsCount: courseEntity.lessonsCount,
      testsCount: courseEntity.testsCount,
      feedBacksCount: courseEntity.feedBacksCount,
      language: courseEntity.language,
      studentsCount: courseEntity.studentsCount,
      state: courseEntity.state,
      postedDate: courseEntity.postedDate,
      contentcreaterentity: courseEntity.contentcreaterentity != null
          ? Contentcreatermodel.fromEntity(
              entity: courseEntity.contentcreaterentity!,
            ).toJson()
          : {},
      ratingStats: courseEntity.ratingStats,
      declineReason: courseEntity.declineReason,
      declinedAt: courseEntity.declinedAt,
      resubmittedAt: courseEntity.resubmittedAt,
    );
  }
  factory Coursemodel.fromJson(Map<String, dynamic> json) {
    return Coursemodel(
      id: json['id'],
      posterUrl: json['posterUrl'],
      title: json['title'],
      description: json['description'],
      studentsCount: (json['studentsCount'] as num).toInt(),
      price: json['price'],
      subject: json['subject'],
      level: json['level'],
      lessonsCount: (json['lessonsCount'] != null)
          ? (json['lessonsCount'] as num).toInt()
          : 0,
      testsCount: (json['testsCount'] != null)
          ? (json['testsCount'] as num).toInt()
          : 0,
      feedBacksCount: (json['feedBacksCount'] != null)
          ? (json['feedBacksCount'] as num).toInt()
          : 0,
      language: json['language'],
      state: json['state'],
      postedDate: (json['postedDate'] as Timestamp).toDate(),
      contentcreaterentity: json['contentcreaterentity'],
      ratingStats: CourseRatingStatsEntity.fromJson(json),
      declineReason: reasonOrNull(json['declineReason']),
      declinedAt: dateOrNull(json['declinedAt']),
      resubmittedAt: dateOrNull(json['resubmittedAt']),
    );
  }
  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      posterUrl: posterUrl,
      title: title,
      description: description,
      studentsCount: studentsCount,
      price: price,
      language: language,
      lessonsCount: lessonsCount,
      testsCount: testsCount,
      feedBacksCount: feedBacksCount,
      subject: subject,
      level: level,
      state: state,
      postedDate: postedDate,
      contentcreaterentity: Contentcreatermodel.fromJson(
        data: contentcreaterentity,
      ).toEntity(),
      ratingStats: ratingStats,
      declineReason: declineReason,
      declinedAt: declinedAt,
      resubmittedAt: resubmittedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posterUrl': posterUrl,
      'title': title,
      'description': description,
      'studentsCount': studentsCount,
      'lessonsCount': lessonsCount,
      'testsCount': testsCount,
      'feedBacksCount': feedBacksCount,
      'contentcreaterentity': contentcreaterentity,
      'price': price,
      'language': language,
      'subject': subject,
      'level': level,
      'state': state,
      'postedDate': postedDate,
    };
  }

  /// Fields a teacher may change when editing a course. Updating only these
  /// (instead of re-writing the whole document) keeps server-maintained
  /// values intact: rating stats, studentsCount and the other counters.
  Map<String, dynamic> toEditableJson() {
    return {
      'title': title,
      'description': description,
      'posterUrl': posterUrl,
      'price': price,
      'language': language,
      'subject': subject,
      'level': level,
      'state': state,
    };
  }
}
