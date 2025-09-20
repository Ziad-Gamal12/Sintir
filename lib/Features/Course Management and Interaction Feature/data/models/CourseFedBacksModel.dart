import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class Coursefeedbacksmodel {
  final String userImage, uid, name, fedBack;
  final int likesCount;
  final DateTime datePosted;

  Coursefeedbacksmodel(
      {required this.userImage,
      required this.name,
      required this.uid,
      required this.fedBack,
      required this.likesCount,
      required this.datePosted});

  factory Coursefeedbacksmodel.fromEntity(
      {required CoursefeedbackItemEntity coursefedbackItemEntity}) {
    return Coursefeedbacksmodel(
      userImage: coursefedbackItemEntity.userImage,
      name: coursefedbackItemEntity.name,
      uid: coursefedbackItemEntity.uid,
      fedBack: coursefedbackItemEntity.fedBack,
      likesCount: coursefedbackItemEntity.likesCount,
      datePosted: coursefedbackItemEntity.datePosted,
    );
  }
  factory Coursefeedbacksmodel.fromJson(Map<String, dynamic> json) {
    return Coursefeedbacksmodel(
      userImage: json["userImage"],
      uid: json["uid"],
      name: json["name"],
      fedBack: json["fedBack"],
      likesCount: (json["likesCount"] as num).toInt(),
      datePosted: (json["datePosted"] as Timestamp).toDate(),
    );
  }
  CoursefeedbackItemEntity toEntity() => CoursefeedbackItemEntity(
        userImage: userImage,
        name: name,
        fedBack: fedBack,
        likesCount: likesCount,
        uid: uid,
        datePosted: datePosted,
      );
  Map<String, dynamic> toJson() => {
        "userImage": userImage,
        "name": name,
        "fedBack": fedBack,
        "likesCount": likesCount,
        "uid": uid,
        "datePosted": datePosted,
      };
}
