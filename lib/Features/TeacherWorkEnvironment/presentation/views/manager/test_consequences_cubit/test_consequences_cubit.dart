import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';

part 'test_consequences_state.dart';

class TestConsequencesCubit extends Cubit<TestConsequencesState> {
  TestConsequencesCubit(
      {required this.testRepo, required this.courseSubscibtionsRepo})
      : super(TestConsequencesInitial());
  final Testitemrepo testRepo;
  final CourseSubscibtionsRepo courseSubscibtionsRepo;
  Future<void> getHighestScore({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    emit(TestConsequencesGetHighestScorLoading());
    final result = await testRepo.getHighestScore(
        courseId: courseId, sectionId: sectionId, sectionItemId: testId);
    result.fold((failure) {
      emit(TestConsequencesGetHighestScorFailure(errMessage: failure.message));
    }, (success) {
      emit(TestConsequencesGetHighestScorSuccess(testResultEntity: success));
    });
  }

  Future<void> getLowestScore({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    emit(TestConsequencesGetLowestScorLoading());
    final result = await testRepo.getLowestScore(
        courseId: courseId, sectionId: sectionId, sectionItemId: testId);
    result.fold((failure) {
      emit(TestConsequencesGetLowestScorFailure(errMessage: failure.message));
    }, (success) {
      emit(TestConsequencesGetLowestScorSuccess(testResultEntity: success));
    });
  }

  Future<void> getAttendedCount({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    emit(TestConsequencesGetAttendedCountLoading());
    final result = await testRepo.getAttendedCount(
        courseId: courseId, sectionId: sectionId, testId: testId);
    result.fold((failure) {
      emit(
          TestConsequencesGetAttendedCountFailure(errMessage: failure.message));
    }, (success) {
      emit(TestConsequencesGetAttendedCountSuccess(count: success));
    });
  }

  Future<void> getFailedStudentsCount({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    emit(TestConsequencesGetFailedCountLoading());
    final result = await testRepo.getFailedStudentsCount(
        courseId: courseId, sectionId: sectionId, testId: testId);
    result.fold((failure) {
      emit(TestConsequencesGetFailedCountFailure(errMessage: failure.message));
    }, (success) {
      emit(TestConsequencesGetFailedCountSuccess(count: success));
    });
  }

  Future<void> getSuccessedStudentsCount({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    emit(TestConsequencesGetSuccessedCountLoading());
    final result = await testRepo.getSuccessedStudentsCount(
        courseId: courseId, sectionId: sectionId, testId: testId);
    result.fold((failure) {
      emit(TestConsequencesGetSuccessedCountFailure(
          errMessage: failure.message));
    }, (success) {
      emit(TestConsequencesGetSuccessedCountSuccess(count: success));
    });
  }

  Future<void> getTotalStudentsCount({
    required String courseId,
  }) async {
    emit(TestConsequencesGetTotalStudentsCountLoading());
    final result =
        await courseSubscibtionsRepo.getSubscribersCount(courseID: courseId);
    result.fold((failure) {
      emit(TestConsequencesGetTotalStudentsCountFailure(
          errMessage: failure.message));
    }, (success) {
      emit(TestConsequencesGetTotalStudentsCountSuccess(count: success));
    });
  }
}
