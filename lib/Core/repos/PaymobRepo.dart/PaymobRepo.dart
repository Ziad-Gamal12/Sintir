import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/PayMobResponse.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

abstract class PaymobRepo {
  Future<Either<Failure, PayMobResponse>> payWithWallet(
      {required UserEntity user, required CourseEntity course});
}
