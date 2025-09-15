import 'package:sintir/Features/Auth/Domain/Entities/TeacherExtraDataEntity.dart';

class TeacherExtraDataModel {
  final String subject;
  final String workExperience;
  TeacherExtraDataModel({required this.subject, required this.workExperience});

  factory TeacherExtraDataModel.fromJson(Map<String, dynamic> json) {
    return TeacherExtraDataModel(
      subject: json['subject'],
      workExperience: json['workExperience'],
    );
  }
  factory TeacherExtraDataModel.fromEntity(TeacherExtraDataEntity entity) {
    return TeacherExtraDataModel(
      subject: entity.subject,
      workExperience: entity.workExperience,
    );
  }
  TeacherExtraDataEntity toEntity() {
    return TeacherExtraDataEntity(
      subject: subject,
      workExperience: workExperience,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'workExperience': workExperience,
    };
  }
}
