import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';

class Coursefilemodel {
  final String title;
  final String filePath;
  final String description;
  String? type;

  Coursefilemodel(
      {required this.title,
      required this.filePath,
      required this.description,
      this.type = "File"});
  factory Coursefilemodel.fromJson(Map<String, dynamic> json) {
    return Coursefilemodel(
      title: json['title'],
      filePath: json['filePath'],
      description: json['description'],
      type: json['type'],
    );
  }
  factory Coursefilemodel.fromEntity(Coursefileentity coursefileentity) {
    return Coursefilemodel(
      title: coursefileentity.title,
      filePath: coursefileentity.fileUrl,
      description: coursefileentity.description,
      type: coursefileentity.type,
    );
  }
  Coursefileentity toEnity() => Coursefileentity(
        title: title,
        fileUrl: filePath,
        description: description,
        type: type,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'filePath': filePath,
        'description': description,
        'type': type,
      };
}
