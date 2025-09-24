import 'package:sintir/Core/utils/imageAssets.dart';

class CoursedetailsviewOptionitemEntity {
  final String title;
  final String imageurl;
  CoursedetailsviewOptionitemEntity({
    required this.title,
    required this.imageurl,
  });
  static List<CoursedetailsviewOptionitemEntity> toList() {
    return [
      CoursedetailsviewOptionitemEntity(
          title: "المحتوى", imageurl: Assets.assetsImagesContentManagement),
      CoursedetailsviewOptionitemEntity(
          title: "الطلاب", imageurl: Assets.assetsImagesStudents),
      CoursedetailsviewOptionitemEntity(
          title: "أراء الطلاب", imageurl: Assets.assetsImagesFeedback),
      CoursedetailsviewOptionitemEntity(
          title: "الأبلاغات", imageurl: Assets.assetsImagesComplain),
    ];
  }
}
