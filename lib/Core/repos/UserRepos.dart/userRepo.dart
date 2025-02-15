import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/UserEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Userrepo {
  Future<Either<Failure, UserEntity>> getUserData();
}
