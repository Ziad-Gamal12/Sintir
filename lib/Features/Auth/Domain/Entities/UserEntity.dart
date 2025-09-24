import 'package:sintir/Features/Auth/Domain/Entities/StudentExtraDataEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherExtraDataEntity.dart';

class UserEntity {
  String uid;
  String firstName;
  String lastName;
  String fullName;
  String email;
  String address;
  String phoneNumber;
  TeacherExtraDataEntity? teacherExtraDataEntity;
  StudentExtraDataEntity? studentExtraDataEntity;
  String gender;
  final String profilePicurl;
  final String status;
  final String role;
  final String joinedDate;

  UserEntity(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.address,
      required this.phoneNumber,
      required this.gender,
      required this.profilePicurl,
      required this.status,
      required this.role,
      required this.joinedDate,
      required this.fullName,
      this.studentExtraDataEntity,
      this.teacherExtraDataEntity});
}
