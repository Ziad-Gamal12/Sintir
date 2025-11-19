import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class PersonalDetailsRepo {
  Future<Either<Failure, void>> updatedUserProfilePic({
    required String uid,
  });
}
