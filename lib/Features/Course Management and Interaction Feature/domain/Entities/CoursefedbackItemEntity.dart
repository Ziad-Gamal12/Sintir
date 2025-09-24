class CoursefeedbackItemEntity {
  String userImage, uid, name, fedBack;
  final int likesCount;
  final DateTime datePosted;

  CoursefeedbackItemEntity(
      {required this.userImage,
      required this.name,
      required this.uid,
      required this.fedBack,
      required this.likesCount,
      required this.datePosted});
}
