// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';

class StudentauthModel {
  final String firstName, lastName;
  final String email;
  final String uid;
  final String birthDate;
  final String gender;
  final String schoolName;
  final String educationLevel;
  final String imageUrl;
  final String phoneNumber;
  final String kind;
  StudentauthModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.uid,
      required this.birthDate,
      required this.gender,
      required this.schoolName,
      required this.educationLevel,
      required this.imageUrl,
      required this.phoneNumber,
      required this.kind});

  factory StudentauthModel.fromEntity({required Studententity studententity}) {
    return StudentauthModel(
      firstName: studententity.firstName,
      lastName: studententity.lastName,
      email: studententity.email,
      birthDate: studententity.birthDate,
      gender: studententity.gender,
      schoolName: studententity.schoolName,
      educationLevel: studententity.educationLevel,
      uid: studententity.uid ?? "",
      imageUrl: studententity.imageUrl,
      phoneNumber: studententity.phoneNumber,
      kind: studententity.kind,
    );
  }

  factory StudentauthModel.fromJson({required Map<String, dynamic> data}) {
    return StudentauthModel(
      firstName: data["firstName"],
      lastName: data["lastName"],
      email: data["email"],
      birthDate: data["birthDate"].toString(),
      gender: data["gender"],
      schoolName: data["schoolName"],
      educationLevel: data["educationLevel"],
      uid: data["id"],
      imageUrl: data["imageUrl"],
      phoneNumber: data["phoneNumber"],
      kind: data["kind"],
    );
  }
  factory StudentauthModel.fromFirebase({required User user}) {
    return StudentauthModel(
      firstName: user.displayName!.split(" ")[0],
      lastName: "",
      email: user.email!,
      uid: user.uid,
      birthDate: "",
      gender: "",
      schoolName: "",
      educationLevel: "",
      imageUrl: "",
      phoneNumber: "",
      kind: "student",
    );
  }
  Studententity toEntity() {
    return Studententity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      birthDate: birthDate,
      gender: gender,
      schoolName: schoolName,
      educationLevel: educationLevel,
      uid: uid,
      imageUrl: imageUrl,
      phoneNumber: phoneNumber,
      kind: kind,
    );
  }

  toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "birthDate": birthDate,
      "gender": gender,
      "schoolName": schoolName,
      "educationLevel": educationLevel,
      "id": uid,
      "imageUrl": imageUrl,
      "phoneNumber": phoneNumber,
      "kind": kind
    };
  }
}
