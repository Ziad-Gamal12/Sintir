class CoursefedbackItemEntity {
  final String userImage, name, fedBack, likesCount;
  final DateTime datePosted;

  CoursefedbackItemEntity(
      {required this.userImage,
      required this.name,
      required this.fedBack,
      required this.likesCount,
      required this.datePosted});
}
