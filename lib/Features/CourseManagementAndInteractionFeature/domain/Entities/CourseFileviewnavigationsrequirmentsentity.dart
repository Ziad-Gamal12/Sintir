import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFileEntity.dart';

class Coursefileviewnavigationsrequirmentsentity {
  final CourseFileEntity file;
  final CourseEntity course;
  final String sectionId;

  Coursefileviewnavigationsrequirmentsentity(
      {required this.file, required this.course, required this.sectionId});
}
