import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Search/Domain/Entities/SearchResponse.dart';

abstract class SearchRepo {
  Future<Either<Failure, SearchResponse>> search({
    required String keyword,
  });

  Future<SearchResponse> searchTeachers({
    required String keyword,
  });

  Future<SearchResponse> searchCourses({
    required String keyword,
  });
  Future<SearchResponse> searchCoursesByContentCreatorName({
    required String keyword,
  });
  Future<Either<Failure, SearchResponse>> getDefaultCourses();
  Future<Either<Failure, SearchResponse>> getDefaultTeachers();
}
