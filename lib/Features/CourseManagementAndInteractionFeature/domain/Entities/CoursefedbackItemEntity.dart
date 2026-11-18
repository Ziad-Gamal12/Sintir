import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFeedbackReplyEntity.dart';

class CoursefeedbackItemEntity {
  String userImage, uid, name, fedBack;
  final DateTime datePosted;

  final int? rating;

  final DateTime? updatedAt;

  final CourseFeedbackReplyEntity? teacherReply;

  CoursefeedbackItemEntity({
    required this.userImage,
    required this.name,
    required this.uid,
    required this.fedBack,
    required this.datePosted,
    this.rating,
    this.updatedAt,
    this.teacherReply,
  });

  CoursefeedbackItemEntity copyWith({
    CourseFeedbackReplyEntity? teacherReply,
    bool clearReply = false,
  }) => CoursefeedbackItemEntity(
    userImage: userImage,
    name: name,
    uid: uid,
    fedBack: fedBack,
    datePosted: datePosted,
    rating: rating,
    updatedAt: updatedAt,
    teacherReply: clearReply ? null : (teacherReply ?? this.teacherReply),
  );

  bool get isEdited {
    final updated = updatedAt;
    return updated != null &&
        updated.difference(datePosted) > const Duration(seconds: 1);
  }

  static CoursefeedbackItemEntity empty() => CoursefeedbackItemEntity(
    userImage: "https://cdn-icons-png.flaticon.com/128/6356/6356630.png",
    name: "loading",
    uid: "loading",
    fedBack: "loading",
    datePosted: DateTime.now(),
    rating: 5,
  );
}
