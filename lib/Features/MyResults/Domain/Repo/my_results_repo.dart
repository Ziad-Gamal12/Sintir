import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/MyResults/Domain/Entities/get_my_results_response_entity.dart';

abstract class MyResultsRepo {
  Future<Either<Failure, GetMyResultsResponseEntity>> getMyResults(
      {required String userId, required bool isPaginate});

  void invalidateOverviewCache({required String userId});
}
