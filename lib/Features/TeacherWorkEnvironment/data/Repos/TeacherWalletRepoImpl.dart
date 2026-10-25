import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';

class TeacherWalletRepoImpl implements TeacherWalletRepo {
  TeacherWalletRepoImpl();

  @override
  Future<Either<Failure, void>> updateTeacherWalletBalance(
      {required String teacherId, required double balance}) async {
    return left(ServerFailure(
        message: 'Wallet balances can only be changed by the server.'));
  }
}
