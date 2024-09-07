import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';

abstract class TeacherAuthRepos {
  Future<Either<Failure, teacherEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    required String subject,
    required String workExperience,
    required String gender,
    required String profilePicurl,
    required String state,
  });
  Future<Either<Failure, String>> uploadProfilePoc(
      {required ImageSource source});
  Future<void> addTeacherData(
      {required String key,
      required Map<String, dynamic> data,
      required String docId});
  Future<void> deleteImage({required String url});
}
