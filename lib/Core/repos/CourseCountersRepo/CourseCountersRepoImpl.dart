import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/Enums/courseCounterField.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/repos/CourseCountersRepo/CourseCountersRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';

class CourseCountersRepoImpl implements CourseCountersRepo {
  final DataBaseService databaseservice;

  CourseCountersRepoImpl({required this.databaseservice});

  @override
  Future<void> updateCourseCounters({
    required String courseId,
    required String teacherId,
    required CourseCounterField field,
    required int delta,
  }) async {
    if (delta == 0) return;
    await updateMultipleCourseCounters(
      courseId: courseId,
      teacherId: teacherId,
      deltas: {field: delta},
    );
  }

  @override
  Future<void> updateMultipleCourseCounters({
    required String courseId,
    required String teacherId,
    required Map<CourseCounterField, int> deltas,
  }) async {
    final Map<String, dynamic> updatePayload = {};
    deltas.forEach((field, delta) {
      if (delta != 0) {
        updatePayload[field.key] = FieldValue.increment(delta);
      }
    });

    if (updatePayload.isEmpty) return;

    await Future.wait([
      databaseservice.updateData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
        ),
        data: updatePayload,
      ),
      databaseservice.updateData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: teacherId,
          subCollection: BackendEndpoints.coursesCollection,
          subDocId: courseId,
        ),
        data: updatePayload,
      ),
    ]);
  }
}
