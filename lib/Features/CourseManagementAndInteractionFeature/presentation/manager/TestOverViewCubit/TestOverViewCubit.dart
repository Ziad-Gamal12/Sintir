import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';

part 'TestOverViewState.dart';

class TestOverViewCubit extends Cubit<TestOverViewState> {
  TestOverViewCubit({required this.testitemrepo})
      : super(GetUserPerviousResultsOfExamInitial());
  final Testitemrepo testitemrepo;

  Future<void> getUserPerviousResultsOfExam(
      {required String courseId,
      required String sectionId,
      required String examId,
      required String userId}) async {
    emit(GetUserPerviousResultsOfExamLoading());
    final result = await testitemrepo.getUserResultsOfExam(
        courseId: courseId,
        sectionId: sectionId,
        examId: examId,
        userId: userId);
    result.fold(
        (failure) => emit(
            GetUserPerviousResultsOfExamFailure(errMessage: failure.message)),
        (results) => emit(
            GetUserPerviousResultsOfExamSuccess(resultsOfExamsList: results)));
  }

//hasReachedMaxAttempts
  Future<void> hasReachedMaxAttempts(
      {required String courseId,
      required String sectionId,
      required CourseTestEntity test,
      required String userId}) async {
    emit(HasReachedMaxAttemptsLoading());
    final result = await testitemrepo.hasReachedMaxAttempts(
        courseId: courseId, sectionId: sectionId, test: test, userId: userId);
    result.fold(
        (failure) =>
            emit(HasReachedMaxAttemptsFailure(errMessage: failure.message)),
        (results) =>
            emit(HasReachedMaxAttemptsSuccess(hasReachedMaxAttempts: results)));
  }
}
