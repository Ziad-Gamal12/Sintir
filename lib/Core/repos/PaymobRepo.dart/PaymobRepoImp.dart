import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/Paymob/PayMobService.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/locale_keys.dart';

class PaymobRepoImp implements PaymobRepo {
  final PayMobService payMobService;
  PaymobRepoImp({required this.payMobService});

  @override
  Future<Either<Failure, PayMobResponse>> payWithWallet({
    required UserEntity user,
    required CourseEntity course,
    required double amount,
  }) async {
    return left(ServerFailure(message: LocaleKeys.unexpectedError));
  }
}
