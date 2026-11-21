import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/RequiresPhoneNumber/Domain/Repos/UpdatePhoneNumberRepo.dart';
import 'package:sintir/locale_keys.dart';

class UpdatePhoneNumberRepoImpl implements UpdatePhoneNumberRepo {
  final DataBaseService dataBaseService;

  UpdatePhoneNumberRepoImpl({required this.dataBaseService});
  @override
  Future<Either<Failure, void>> updatePhoneNumber({
    required String uid,
    required String phoneNumber,
  }) async {
    try {
      await dataBaseService.updateData(
        data: phoneNumber,
        field: "phoneNumber",
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: uid,
        ),
      );
      return Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}
