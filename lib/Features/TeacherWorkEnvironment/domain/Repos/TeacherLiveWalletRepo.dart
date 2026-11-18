// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';

abstract interface class TeacherLiveWalletRepo {
  Stream<Either<Failure, TeacherWalletEntity>> watchWallet({
    required String teacherId,
  });
}
