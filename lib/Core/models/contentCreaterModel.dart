// ignore_for_file: file_names

import 'package:sintir/Core/entities/ContentCreaterEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

class Contentcreatermodel {
  final String name, profileImageUrl, id, title;

  Contentcreatermodel(
      {required this.name,
      required this.profileImageUrl,
      required this.id,
      required this.title});

  factory Contentcreatermodel.fromTeacherEntity(
      {required teacherEntity teacherEntity}) {
    return Contentcreatermodel(
        name: "${teacherEntity.firstName} ${teacherEntity.lastName}",
        profileImageUrl: teacherEntity.profilePicurl!,
        id: teacherEntity.uid!,
        title: " مدرس/ه${teacherEntity.subject}");
  }
  factory Contentcreatermodel.fromEntity(
      {required Contentcreaterentity entity}) {
    return Contentcreatermodel(
        name: entity.name,
        profileImageUrl: entity.profileImageUrl,
        id: entity.id,
        title: entity.title);
  }
  factory Contentcreatermodel.fromJson({required Map data}) {
    return Contentcreatermodel(
        name: data["name"],
        profileImageUrl: data["profileImageUrl"],
        id: data["id"],
        title: data["title"]);
  }
  Contentcreaterentity toEntity() {
    return Contentcreaterentity(
        name: name, profileImageUrl: profileImageUrl, id: id, title: title);
  }

  toJson() {
    return {
      "name": name,
      "profileImageUrl": profileImageUrl,
      "id": id,
      "title": title
    };
  }
}
