// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';

class StudentauthModel extends Studententity {
  StudentauthModel(
      {required super.firstName,
      required super.lastName,
      required super.email,
      super.birthDate,
      super.gender,
      super.schoolName,
      super.educationLevel,
      super.kind,
      required super.studentID,
      required super.imageUrl,
      required super.phoneNumber,
      super.password});
  factory StudentauthModel.fromUserAndEntity(
      {required User user, required Studententity studententity}) {
    return StudentauthModel(
      firstName: user.displayName ?? "",
      lastName: studententity.lastName,
      email: user.email ?? "",
      birthDate: studententity.birthDate,
      gender: studententity.gender,
      schoolName: studententity.schoolName,
      educationLevel: studententity.educationLevel,
      studentID: user.uid,
      imageUrl: studententity.gender == "ذكر"
          ? "https://cdn-icons-png.flaticon.com/128/2202/2202112.png"
          : "https://cdn-icons-png.flaticon.com/128/6997/6997662.png",
      phoneNumber: studententity.phoneNumber,
      password: studententity.password,
      kind: "student",
    );
  }
  factory StudentauthModel.fromFirebase({required User user}) {
    return StudentauthModel(
      firstName: user.displayName ?? "",
      email: user.email ?? "",
      studentID: user.uid,
      imageUrl: user.photoURL,
      phoneNumber: user.phoneNumber ?? "",
      lastName: '',
      birthDate: null,
      gender: null,
      schoolName: null,
      educationLevel: null,
      kind: "student",
    );
  }
  factory StudentauthModel.fromEntity({required Studententity studententity}) {
    return StudentauthModel(
      firstName: studententity.firstName,
      lastName: studententity.lastName,
      email: studententity.email,
      birthDate: studententity.birthDate,
      gender: studententity.gender,
      schoolName: studententity.schoolName,
      educationLevel: studententity.educationLevel,
      studentID: studententity.studentID,
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
      studentID: data["id"],
      imageUrl: data["imageUrl"],
      phoneNumber: data["phoneNumber"],
      kind: data["kind"],
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
      "id": studentID,
      "imageUrl": imageUrl,
      "phoneNumber": phoneNumber,
      "kind": kind
    };
  }
}
