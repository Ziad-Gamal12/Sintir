import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';

class TeacherWalletRepoImpl implements TeacherWalletRepo {
  final Databaseservice databaseservice;

  TeacherWalletRepoImpl({required this.databaseservice});

  @override
  Future<Either<Failure, void>> updateTeacherWalletBalance(
      {required String teacherId, required double balance}) async {
    try {
      await databaseservice.updateData(
        collectionKey: BackendEndpoints.usersCollectionName,
        field: "teacherExtraData.wallet.balance",
        doc: teacherId,
        data: balance,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
