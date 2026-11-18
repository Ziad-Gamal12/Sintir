// ignore_for_file: file_names

class CourseFeedbackReplyEntity {
  const CourseFeedbackReplyEntity({
    required this.text,
    required this.authorId,
    required this.createdAt,
    this.updatedAt,
  });

  static const int maxLength = 1000;

  final String text;
  final String authorId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  bool get isEdited {
    final updated = updatedAt;
    return updated != null &&
        updated.difference(createdAt) > const Duration(seconds: 1);
  }
}
