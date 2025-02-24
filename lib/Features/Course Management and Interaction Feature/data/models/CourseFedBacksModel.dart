import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class Coursefedbacksmodel {
  final String userImage, name, fedBack, likesCount;
  final DateTime datePosted;

  Coursefedbacksmodel(
      {required this.userImage,
      required this.name,
      required this.fedBack,
      required this.likesCount,
      required this.datePosted});

  factory Coursefedbacksmodel.fromEntity(
      {required CoursefedbackItemEntity coursefedbackItemEntity}) {
    return Coursefedbacksmodel(
      userImage: coursefedbackItemEntity.userImage,
      name: coursefedbackItemEntity.name,
      fedBack: coursefedbackItemEntity.fedBack,
      likesCount: coursefedbackItemEntity.likesCount,
      datePosted: coursefedbackItemEntity.datePosted,
    );
  }
  factory Coursefedbacksmodel.fromJson(Map<String, dynamic> json) {
    return Coursefedbacksmodel(
      userImage: json["userImage"],
      name: json["name"],
      fedBack: json["fedBack"],
      likesCount: json["likesCount"],
      datePosted: (json["datePosted"] as Timestamp).toDate(),
    );
  }
  CoursefedbackItemEntity toEntity() => CoursefedbackItemEntity(
        userImage: userImage,
        name: name,
        fedBack: fedBack,
        likesCount: likesCount,
        datePosted: datePosted,
      );
  Map<String, dynamic> toJson() => {
        "userImage": userImage,
        "name": name,
        "fedBack": fedBack,
        "likesCount": likesCount,
        "datePosted": datePosted.toIso8601String(),
      };
}
