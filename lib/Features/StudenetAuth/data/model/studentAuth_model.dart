import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';

class StudentauthModel extends Studententity {
  StudentauthModel(
      {required super.firstName,
      required super.lastName,
      required super.email,
      required super.birthDate,
      required super.gender,
      required super.schoolName,
      required super.educationLevel,
      required super.studentID,
      required super.imageUrl,
      required super.phoneNumber,
      required super.password});
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
      "studentID": studentID,
      "imageUrl": imageUrl,
      "phoneNumber": phoneNumber,
    };
  }
}
