// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class UpdatePhoneNumberRepo {
  Future<Either<Failure, void>> updatePhoneNumber({
    required String uid,
    required String phoneNumber,
  });
}
