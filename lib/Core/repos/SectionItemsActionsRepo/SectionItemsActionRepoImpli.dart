import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursefileModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursevedioitemModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/JoinedByModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';

class SectionItemsActionsRepoImpli implements SectionItemsActionsRepo {
  final DataBaseService datebaseservice;

  SectionItemsActionsRepoImpli({required this.datebaseservice});

  @override
  Future<Either<Failure, void>> addSectionItem({
    required sectionItem,
    required String courseId,
    required String sectionId,
  }) async {
    try {
      if (sectionItem is CourseTestEntity) {
        Map<String, dynamic> json =
            Coursetestmodel.fromEntity(sectionItem).toJson();
        await datebaseservice.setData(
            requirements: FireStoreRequirmentsEntity(
                collection: BackendEndpoints.coursesCollection,
                docId: courseId,
                subCollection: BackendEndpoints.sectionsSubCollection,
                subDocId: sectionId,
                subCollection2: BackendEndpoints.sectionItemsSubCollection,
                sub2DocId: sectionItem.id),
            data: json);
        return right(null);
      } else if (sectionItem is CourseVideoItemEntity) {
        Map<String, dynamic> json =
            Coursevedioitemmodel.fromEntity(sectionItem).toJson();
        await datebaseservice.setData(
            requirements: FireStoreRequirmentsEntity(
                collection: BackendEndpoints.coursesCollection,
                docId: courseId,
                subCollection: BackendEndpoints.sectionsSubCollection,
                subDocId: sectionId,
                subCollection2: BackendEndpoints.sectionItemsSubCollection,
                sub2DocId: sectionItem.id),
            data: json);
        return right(null);
      } else if (sectionItem is CourseFileEntity) {
        Map<String, dynamic> json =
            Coursefilemodel.fromEntity(sectionItem).toJson();
        await datebaseservice.setData(
            requirements: FireStoreRequirmentsEntity(
                collection: BackendEndpoints.coursesCollection,
                docId: courseId,
                subCollection: BackendEndpoints.sectionsSubCollection,
                subDocId: sectionId,
                subCollection2: BackendEndpoints.sectionItemsSubCollection,
                sub2DocId: sectionItem.id),
            data: json);
        return right(null);
      } else {
        return left(
            ServerFailure(message: "العنصر غير معرف, يرجى المحاولة مرة أخرى"));
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List>> getSectionsItems(
      {required String courseId, required String sectionId}) async {
    try {
      List items = [];
      FireStoreResponse data = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
        ),
      );
      if (data.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (data.listData!.isEmpty) {
        return right([]);
      }
      for (var item in data.listData!) {
        if (item["type"] == "Test") {
          items.add(Coursetestmodel.fromJson(item).toEntity());
        } else if (item["type"] == "Vedio") {
          items.add(Coursevedioitemmodel.fromJson(item).toEntity());
        } else {
          items.add(Coursefilemodel.fromJson(item).toEntity());
        }
      }
      return right(items);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> addJoinedBy(
      {required JoinedByEntity joinedByEntity,
      required String courseId,
      required String sectionId,
      required String sectionItemId}) async {
    try {
      Map<String, dynamic> json =
          JoinedbyModel.fromEntity(joinedByEntity).toJson();
      await datebaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.coursesCollection,
              docId: courseId,
              subCollection: BackendEndpoints.sectionsSubCollection,
              subDocId: sectionId,
              subCollection2: BackendEndpoints.sectionItemsSubCollection,
              sub2DocId: sectionItemId,
              subCollection3: BackendEndpoints.joinedBySubCollection,
              sub3DocId: joinedByEntity.uid),
          data: json);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
