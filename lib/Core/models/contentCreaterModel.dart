// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class Contentcreatermodel {
  final String name, profileImageUrl, id, title;

  Contentcreatermodel(
      {required this.name,
      required this.profileImageUrl,
      required this.id,
      required this.title});

  factory Contentcreatermodel.fromTeacherEntity(
      {required UserEntity userEntity}) {
    return Contentcreatermodel(
        name: "${userEntity.firstName} ${userEntity.lastName}",
        profileImageUrl: userEntity.profilePicurl,
        id: userEntity.uid,
        title: " مدرس/ه${userEntity.teacherExtraDataEntity?.subject}");
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
