import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/ContentCreatorProfile/domain/Repos/ContentCreatorProfileRepo.dart';

class ContentCreatorProfileRepoImpl implements ContentCreatorProfileRepo {
  final DataBaseService dataBaseService;

  ContentCreatorProfileRepoImpl({required this.dataBaseService});
  @override
  Future<Either<Failure, List<CourseEntity>>> getContentCreatorCourses(
      {required String userId}) async {
    try {
      Map<String, dynamic> query = {
        "orderBy": "studentsCount",
        "filters": <Map<String, dynamic>>[
          {
            "field": "contentcreaterentity.id",
            "operator": "==",
            "value": userId,
          },
          {
            "field": "state",
            "operator": "==",
            "value": BackendEndpoints.coursePublishedState,
          },
        ],
      };
      final response = await dataBaseService.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
          ),
          query: query);
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      final List<Map<String, dynamic>> data =
          response.listData! as List<Map<String, dynamic>>;
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> searchContentCreatorCourses(
      {required String userId, required String keyword}) async {
    try {
      Map<String, dynamic> query = {
        "orderBy": "studentsCount",
        "searchField": "title",
        "searchValue": keyword,
        "filters": <Map<String, dynamic>>[
          {
            "field": "contentcreaterentity.id",
            "operator": "==",
            "value": userId,
          },
          {
            "field": "state",
            "operator": "==",
            "value": BackendEndpoints.coursePublishedState,
          },
        ],
      };
      final response = await dataBaseService.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
          ),
          query: query);
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      final List<Map<String, dynamic>> data =
          response.listData! as List<Map<String, dynamic>>;
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
