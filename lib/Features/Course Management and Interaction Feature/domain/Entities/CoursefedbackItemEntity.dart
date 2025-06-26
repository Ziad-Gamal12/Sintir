class CoursefeedbackItemEntity {
  final String userImage, name, fedBack, likesCount;
  final DateTime datePosted;

  CoursefeedbackItemEntity(
      {required this.userImage,
      required this.name,
      required this.fedBack,
      required this.likesCount,
      required this.datePosted});
}
