import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';

class Coursefileviewnavigationsrequirmentsentity {
  final Coursefileentity file;
  final CourseEntity course;

  Coursefileviewnavigationsrequirmentsentity(
      {required this.file, required this.course});
}
