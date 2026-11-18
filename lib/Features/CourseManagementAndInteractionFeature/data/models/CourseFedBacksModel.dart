import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFeedbackReplyEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

class Coursefeedbacksmodel {
  final String userImage, uid, name, fedBack;
  final DateTime datePosted;
  final int? rating;
  final DateTime? updatedAt;
  final CourseFeedbackReplyEntity? teacherReply;

  Coursefeedbacksmodel({
    required this.userImage,
    required this.name,
    required this.uid,
    required this.fedBack,
    required this.datePosted,
    this.rating,
    this.updatedAt,
    this.teacherReply,
  });

  @Deprecated(
    'Feedback is written only by the upsert-course-feedback Edge Function.',
  )
  factory Coursefeedbacksmodel.fromEntity({
    required CoursefeedbackItemEntity coursefedbackItemEntity,
  }) {
    return Coursefeedbacksmodel(
      userImage: coursefedbackItemEntity.userImage,
      name: coursefedbackItemEntity.name,
      uid: coursefedbackItemEntity.uid,
      fedBack: coursefedbackItemEntity.fedBack,
      datePosted: coursefedbackItemEntity.datePosted,
      rating: coursefedbackItemEntity.rating,
      updatedAt: coursefedbackItemEntity.updatedAt,
    );
  }

  /// Reads a Firestore feedback document or the `feedback` object returned by
  /// the Edge Function (dates as ISO-8601 strings). Old documents without
  /// `rating` / `updatedAt` are valid. Throws [FormatException] only when the
  /// document has no author uid or no date, so callers can skip it.
  factory Coursefeedbacksmodel.fromJson(Map<String, dynamic> json) {
    final uid = json["uid"];
    final datePosted = _date(json["datePosted"]);
    if (uid is! String || uid.isEmpty || datePosted == null) {
      throw const FormatException('Invalid course feedback document.');
    }
    return Coursefeedbacksmodel(
      userImage: _string(json["userImage"]),
      uid: uid,
      name: _string(json["name"]),
      fedBack: _string(json["fedBack"]),
      datePosted: datePosted,
      rating: parseRating(json["rating"]),
      updatedAt: _date(json["updatedAt"]),
      teacherReply: parseReply(json["teacherReply"]),
    );
  }

  /// A reply counts only with non-empty text and a creation date.
  static CourseFeedbackReplyEntity? parseReply(Object? value) {
    if (value is! Map) return null;
    final text = value["text"];
    final createdAt = _date(value["createdAt"]);
    if (text is! String || text.trim().isEmpty || createdAt == null) {
      return null;
    }
    return CourseFeedbackReplyEntity(
      text: text.trim(),
      authorId: _string(value["authorId"]),
      createdAt: createdAt,
      updatedAt: _date(value["updatedAt"]),
    );
  }

  /// A stored rating counts only when it is a whole number from 1 to 5.
  static int? parseRating(Object? value) {
    if (value is! num || !value.isFinite) return null;
    if (value != value.roundToDouble() || value < 1 || value > 5) return null;
    return value.toInt();
  }

  static DateTime? _date(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value)?.toLocal();
    return null;
  }

  static String _string(Object? value) => value is String ? value : '';

  CoursefeedbackItemEntity toEntity() => CoursefeedbackItemEntity(
    userImage: userImage,
    name: name,
    fedBack: fedBack,
    uid: uid,
    datePosted: datePosted,
    rating: rating,
    updatedAt: updatedAt,
    teacherReply: teacherReply,
  );

  @Deprecated(
    'Feedback is written only by the upsert-course-feedback Edge Function.',
  )
  Map<String, dynamic> toJson() => {
    "userImage": userImage,
    "name": name,
    "fedBack": fedBack,
    "uid": uid,
    "datePosted": datePosted,
    if (rating != null) "rating": rating,
    if (updatedAt != null) "updatedAt": updatedAt,
  };
}
