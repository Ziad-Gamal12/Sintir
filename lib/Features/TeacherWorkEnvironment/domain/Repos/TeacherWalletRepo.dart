import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class TeacherWalletRepo {
  Future<Either<Failure, void>> updateTeacherWalletBalance(
      {required String teacherId, required double balance});
}
