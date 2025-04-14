// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/UserEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Userrepo {
  Future<Either<Failure, UserEntity>> getUserData();
}
