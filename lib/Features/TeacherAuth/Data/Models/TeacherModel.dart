// ignore_for_file: file_names

import 'dart:convert';

import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

class Teachermodel {
  final String firstName;
  final String lastName;
  final String email;
  final String uid;
  final String address;
  final String phoneNumber;
  final String subject;
  final String workExperience;
  final String gender;
  final String profilePicurl;
  final String state;
  final List socialLinks;
  final String kind; //teacher or Studednt
  final String joinedDate;
  Teachermodel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.uid,
      required this.address,
      required this.phoneNumber,
      required this.subject,
      required this.workExperience,
      required this.gender,
      required this.profilePicurl,
      required this.state,
      required this.socialLinks,
      required this.kind,
      required this.joinedDate});

  factory Teachermodel.fromEntity({
    required teacherEntity teacherentity,
  }) {
    return Teachermodel(
      uid: teacherentity.uid ?? "",
      firstName: teacherentity.firstName,
      lastName: teacherentity.lastName,
      email: teacherentity.email,
      profilePicurl: teacherentity.profilePicurl ?? "",
      phoneNumber: teacherentity.phoneNumber,
      address: teacherentity.address,
      subject: teacherentity.subject,
      workExperience: teacherentity.workExperience,
      gender: teacherentity.gender,
      state: teacherentity.state,
      socialLinks: teacherentity.socialLinks,
      kind: teacherentity.kind,
      joinedDate: teacherentity.joinedDate,
    );
  }
  factory Teachermodel.fromMap(Map<String, dynamic> map) {
    return Teachermodel(
      uid: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      profilePicurl: map['profilePicurl'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      subject: map['subject'],
      workExperience: map['workExperience'],
      gender: map['gender'],
      state: map['state'],
      socialLinks: map['socialLinks'],
      kind: map['kind'],
      joinedDate: map['joinedDate'],
    );
  }

  teacherEntity toEntity() {
    return teacherEntity(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      profilePicurl: profilePicurl,
      phoneNumber: phoneNumber,
      address: address,
      subject: subject,
      workExperience: workExperience,
      gender: gender,
      state: state,
      socialLinks: socialLinks,
      kind: kind,
      joinedDate: joinedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "id": uid,
      "address": address,
      "phoneNumber": phoneNumber,
      "subject": subject,
      "workExperience": workExperience,
      "gender": gender,
      "profilePicurl": profilePicurl,
      "state": state,
      "socialLinks": jsonEncode(socialLinks),
      "kind": kind,
      "joinedDate": joinedDate
    };
  }
}
