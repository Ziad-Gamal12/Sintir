import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Domain/Entities/SearchResponse.dart';

abstract class SearchRepo {
  Future<Either<Failure, SearchResponse>> search(
      {required String keyword,
      required CourseFilterEntity? filters,
      required String? userId});

  Future<SearchResponse> searchTeachers({
    required String keyword,
  });

  Future<SearchResponse> searchCourses(
      {required String keyword,
      required CourseFilterEntity? filters,
      required String? userId});
  Future<SearchResponse> searchCoursesByContentCreatorName(
      {required String keyword,
      required CourseFilterEntity? filters,
      required String? userId});
  Future<Either<Failure, SearchResponse>> getDefaultCourses(
      {required CourseFilterEntity? filters, required String? userId});
  Future<Either<Failure, SearchResponse>> getDefaultTeachers();
}
