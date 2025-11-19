import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class FavoritesRepo {
  Future<Either<Failure, void>> addToFavorites(
      {required String userId, required CourseEntity course});
  Future<Either<Failure, void>> removeFromFavorites(
      {required String userId, required CourseEntity course});
  Future<Either<Failure, List<CourseEntity>>> getFavorites(
      {required String userId});
}
