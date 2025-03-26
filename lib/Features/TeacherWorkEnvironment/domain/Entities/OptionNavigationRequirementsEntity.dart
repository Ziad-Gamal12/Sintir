import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';

class Optionnavigationrequirementsentity {
  final CoursSectionsListItemEntity section;
  final CourseEntity course;

  Optionnavigationrequirementsentity(
      {required this.section, required this.course});
}
