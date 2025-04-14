import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/JoinedByModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';

class Coursefilemodel {
  final String title;
  final String filePath;
  final String description;
  final List<Map<String, dynamic>> joinedBy;

  String? type;

  Coursefilemodel(
      {required this.title,
      required this.filePath,
      required this.description,
      required this.joinedBy,
      this.type = "File"});
  factory Coursefilemodel.fromJson(Map<String, dynamic> json) {
    return Coursefilemodel(
      joinedBy: (json['joinedBy'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      title: json['title'],
      filePath: json['filePath'],
      description: json['description'],
      type: json['type'],
    );
  }
  factory Coursefilemodel.fromEntity(Coursefileentity coursefileentity) {
    return Coursefilemodel(
      joinedBy: coursefileentity.joinedBy.map((e) {
        return JoinedbyModel.fromEntity(e).toJson();
      }).toList(),
      title: coursefileentity.title,
      filePath: coursefileentity.fileUrl,
      description: coursefileentity.description,
      type: coursefileentity.type,
    );
  }
  Coursefileentity toEnity() => Coursefileentity(
        joinedBy:
            joinedBy.map((e) => JoinedbyModel.fromJson(e).toEntity()).toList(),
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
        'joinedBy': joinedBy
      };
}
