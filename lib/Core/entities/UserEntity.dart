// ignore_for_file: file_names

import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

class UserEntity {
  teacherEntity? teacher;
  Studententity? student;
  UserEntity({this.teacher, this.student});
}
