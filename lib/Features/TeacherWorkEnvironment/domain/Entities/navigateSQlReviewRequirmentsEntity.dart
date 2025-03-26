import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';

class Navigatesqlreviewrequirmentsentity {
  final CoursSectionsListItemEntity section;
  final CourseEntity courseEntity;
  final Coursetestentity coursetestentity;
  Navigatesqlreviewrequirmentsentity({
    required this.section,
    required this.courseEntity,
    required this.coursetestentity,
  });
}
