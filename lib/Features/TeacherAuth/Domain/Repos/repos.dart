import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';

abstract class TeacherAuthRepos {
  Future<Either<Failure, teacherEntity>> createUserWithEmailAndPassword(
      {required String email, required String password, required String name});
  Future<Either<Failure, String>> uploadProfilePoc(
      {required ImageSource source});
}
