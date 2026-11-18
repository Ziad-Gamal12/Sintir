// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/Enums/courseCounterField.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSectionsResonseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseCountersRepo/CourseCountersRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestAnswerKeyStore.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseSectionModel.dart';
import 'package:sintir/locale_keys.dart';

class CourseSectionsRepoImpl implements CourseSectionsRepo {
  final DataBaseService datebaseservice;
  final CourseCountersRepo courseCountersRepo;
  final TestAnswerKeyStore answerKeys;

  CourseSectionsRepoImpl({
    required this.datebaseservice,
    required this.courseCountersRepo,
    TestAnswerKeyStore? answerKeys,
  }) : answerKeys = answerKeys ?? TestAnswerKeyStore();

  @override
  Future<Either<Failure, void>> addCourseSection({
    required String courseId,
    required CourseSectionEntity section,
  }) async {
    try {
      final json = CourseSectionModel.fromEntity(
        coursSectionsListItemEntity: section,
      ).toJson();

      await datebaseservice.setData(
        data: json,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: section.id,
        ),
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  DocumentSnapshot? getCourseSectionsLastDoc;
  final Map<String, dynamic> _baseQuery = {"startAfter": null, "limit": 10};

  @override
  Future<Either<Failure, GetCourseSectionsResonseEntity>> getCourseSections({
    required String courseId,
    required bool isPaginate,
  }) async {
    try {
      final query = Map<String, dynamic>.from(_baseQuery);
      query["startAfter"] = isPaginate ? getCourseSectionsLastDoc : null;
      final response = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
        ),
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      if (response.listData!.isEmpty) {
        return right(
          GetCourseSectionsResonseEntity(
            isPaginate: isPaginate,
            sections: [],
            hasMore: false,
          ),
        );
      }

      if (response.lastDocumentSnapshot != null) {
        getCourseSectionsLastDoc = response.lastDocumentSnapshot;
      }

      final courseSections = await compute(
        _parseCourseSections,
        response.listData!,
      );

      return right(
        GetCourseSectionsResonseEntity(
          isPaginate: isPaginate,
          sections: courseSections,
          hasMore: response.hasMore ?? false,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  static List<CourseSectionEntity> _parseCourseSections(List<dynamic> data) {
    return data.map((e) => CourseSectionModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<Either<Failure, void>> deleteSection({
    required String courseId,
    required String teacherId,
    required String sectionId,
  }) async {
    try {
      final itemsResponse = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
        ),
      );

      int deletedLessons = 0;
      int deletedTests = 0;
      final List<Future<void>> deleteFutures = [];

      if (itemsResponse.listData != null &&
          itemsResponse.listData!.isNotEmpty) {
        for (final item in itemsResponse.listData!) {
          final String? itemId = item["id"]?.toString();
          final String? type = item["type"]?.toString();

          if (type == "Test") {
            deletedTests++;
          } else {
            deletedLessons++;
          }
          if (type == "Test" && itemId != null && itemId.isNotEmpty) {
            deleteFutures.add(
              answerKeys.deleteAnswerKey(
                courseId: courseId,
                sectionId: sectionId,
                testId: itemId,
              ),
            );
          }
          if (itemId != null && itemId.isNotEmpty) {
            deleteFutures.add(
              datebaseservice.deleteDoc(
                collectionKey: BackendEndpoints.coursesCollection,
                docId: courseId,
                subCollectionKey: BackendEndpoints.sectionsSubCollection,
                subDocId: sectionId,
                subCollectionKey2: BackendEndpoints.sectionItemsSubCollection,
                subDocId2: itemId,
              ),
            );
          }
        }
      }

      deleteFutures.add(
        datebaseservice.deleteDoc(
          collectionKey: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollectionKey: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
        ),
      );

      if (deletedLessons > 0 || deletedTests > 0) {
        deleteFutures.add(
          courseCountersRepo.updateMultipleCourseCounters(
            courseId: courseId,
            teacherId: teacherId,
            deltas: {
              if (deletedLessons > 0)
                CourseCounterField.lessons: -deletedLessons,
              if (deletedTests > 0) CourseCounterField.tests: -deletedTests,
            },
          ),
        );
      }

      await Future.wait(deleteFutures);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}
