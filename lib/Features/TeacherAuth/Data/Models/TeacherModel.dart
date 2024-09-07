import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';

class Teachermodel extends teacherEntity {
  Teachermodel(
      {required super.firstName,
      required super.lastName,
      required super.email,
      required super.uid,
      required super.address,
      required super.phoneNumber,
      required super.subject,
      required super.workExperience,
      required super.gender,
      required super.profilePicurl,
      required super.stete,
      required super.socialLinks});

  factory Teachermodel.fromFirebase({
    required User user,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    required String subject,
    required String workExperience,
    required String gender,
    required String profilePicurl,
    required String state,
  }) {
    return Teachermodel(
      uid: user.uid,
      firstName: firstName,
      lastName: lastName,
      email: user.email!,
      profilePicurl: profilePicurl,
      phoneNumber: phoneNumber,
      address: address,
      subject: subject,
      workExperience: workExperience,
      gender: gender,
      stete: state,
      socialLinks: [],
    );
  }
}
