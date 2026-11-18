// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';

enum AccountSignInMethod { password, google, facebook, other }

class AccountDeletionResult {
  const AccountDeletionResult({
    this.coursesKept = 0,
    this.coursesDeleted = 0,
  });

  final int coursesKept;
  final int coursesDeleted;

  factory AccountDeletionResult.fromJson(Map<String, dynamic> json) {
    int count(Object? value) => value is num ? value.toInt() : 0;
    return AccountDeletionResult(
      coursesKept: count(json['coursesKept']),
      coursesDeleted: count(json['coursesDeleted']),
    );
  }
}

abstract class AccountDeletionRepo {
  AccountSignInMethod signInMethod();

  Future<Either<Failure, AccountDeletionResult>> deleteAccount({
    String? password,
    required bool acknowledgeBalance,
  });
}
