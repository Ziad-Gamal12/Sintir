// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';

abstract class ProfileCompletionRepo {
  UserEntity currentUser();

  Future<Either<Failure, UserEntity>> completeProfile(
    ProfileCompletionInput input,
  );
}
