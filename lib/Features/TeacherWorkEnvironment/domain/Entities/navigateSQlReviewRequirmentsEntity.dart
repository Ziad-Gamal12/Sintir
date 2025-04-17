import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';

class Navigatesqlreviewrequirmentsentity {
  final CourseSectionEntity section;
  final String courseID;
  final Coursetestentity coursetestentity;
  final bool isNewSection;
  Navigatesqlreviewrequirmentsentity({
    required this.section,
    required this.courseID,
    required this.isNewSection,
    required this.coursetestentity,
  });
}
