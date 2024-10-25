// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
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
      required super.socialLinks,
      required super.kind,
      required super.joinedDate});

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
      kind: 'teacher',
      joinedDate: Timestamp.now().toDate().toString(),
    );
  }
  factory Teachermodel.fromMap(Map<String, dynamic> map) {
    return Teachermodel(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      profilePicurl: map['profilePicurl'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      subject: map['subject'],
      workExperience: map['workExperience'],
      gender: map['gender'],
      stete: map['state'],
      socialLinks: map['socialLinks'],
      kind: map['kind'],
      joinedDate: map['joinedDate'],
    );
  }
  factory Teachermodel.fromEntity({required teacherEntity teacherentity}) {
    return Teachermodel(
      uid: teacherentity.uid,
      firstName: teacherentity.firstName,
      lastName: teacherentity.lastName,
      email: teacherentity.email,
      profilePicurl: teacherentity.profilePicurl,
      phoneNumber: teacherentity.phoneNumber,
      address: teacherentity.address,
      subject: teacherentity.subject,
      workExperience: teacherentity.workExperience,
      gender: teacherentity.gender,
      stete: teacherentity.stete,
      socialLinks: teacherentity.socialLinks,
      kind: teacherentity.kind,
      joinedDate: teacherentity.joinedDate,
    );
  }
  @override
  toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "uid": uid,
      "address": address,
      "phoneNumber": phoneNumber,
      "subject": subject,
      "workExperience": workExperience,
      "gender": gender,
      "profilePicurl": profilePicurl,
      "state": stete,
      "socialLinks": socialLinks,
      "kind": kind,
      "joinedDate": joinedDate
    };
  }
}
