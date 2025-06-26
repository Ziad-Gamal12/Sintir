import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/StudentProfile/domain/Entities/StudentProfile_InfoEntity.dart';
import 'package:sintir/Features/StudentProfile/domain/Entities/StundentProfileFavouriteCourseEntity.dart';

class Studentprofileentity {
  final StudentprofileInfoentity studentprofileInfoentity;
  final List<Stundentprofilefavouritecourseentity> favouriteCourses;
  final List<CourseEntity> myCourses;

  Studentprofileentity(
      {required this.studentprofileInfoentity,
      required this.favouriteCourses,
      required this.myCourses});
}
