import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';

class Teachermodel extends teacherEntity {
  Teachermodel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.uid,
  });
  factory Teachermodel.fromFirebase({required User user}) {
    return Teachermodel(
      firstName: user.displayName!,
      lastName: user.displayName!,
      email: user.email!,
      uid: user.uid,
    );
  }
}
