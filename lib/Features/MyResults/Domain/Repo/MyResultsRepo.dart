import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/MyResults/Domain/Entities/GetMyResultsResponseEntity.dart';

abstract class MyResultsRepo {
  Future<Either<Failure, GetMyResultsResponseEntity>> getMyResults(
      {required String userId, required bool isPaginate});
}
