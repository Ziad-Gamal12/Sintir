import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

class CoursereportsitemModel {
  final String date;
  final String type;
  final String description;

  CoursereportsitemModel(
      {required this.date, required this.type, required this.description});
  factory CoursereportsitemModel.fromJson(Map<String, dynamic> json) {
    return CoursereportsitemModel(
      date: json['date'],
      type: json['type'],
      description: json['description'],
    );
  }
  factory CoursereportsitemModel.fromEntity(
      {required Coursereportsitementity courseReportsItemEntity}) {
    return CoursereportsitemModel(
      date: courseReportsItemEntity.date,
      type: courseReportsItemEntity.type,
      description: courseReportsItemEntity.description,
    );
  }
  Coursereportsitementity toEntity() {
    return Coursereportsitementity(
      date: date,
      type: type,
      description: description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'type': type,
      'description': description,
    };
  }
}
