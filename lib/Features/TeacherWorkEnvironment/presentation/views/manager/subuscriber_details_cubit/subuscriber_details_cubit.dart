import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/SubscribersDetailsRepo.dart';

part 'subuscriber_details_state.dart';

class SubscriberDetailsCubit extends Cubit<SubscriberDetailsState> {
  SubscriberDetailsCubit({required this.subscribersDetailsRepo})
      : super(SubuscriberDetailsInitial());
  final SubscribersDetailsRepo subscribersDetailsRepo;
  List<TestResultEntity> subscriberResults = [];

  Future<void> getSubscibersEnrolledCoursesForTeacher({
    required String contentCreatorId,
    required String subscriberId,
  }) async {
    emit(GetSubscibersEnrolledCoursesForTeacherLoading());
    final result =
        await subscribersDetailsRepo.getSubscibersEnrolledCoursesForTeacher(
            contentCreatorId: contentCreatorId, subscriberId: subscriberId);
    result.fold(
        (l) => emit(GetSubscibersEnrolledCoursesForTeacherFailure(
            errmessage: l.message)),
        (courses) => emit(
            GetSubscibersEnrolledCoursesForTeacherSuccess(courses: courses)));
  }

  Future<void> getSubscriberResults({
    required String subscriberId,
    required String courseId,
  }) async {
    emit(GetSubscriberResultsLoading());
    final result = await subscribersDetailsRepo.getSubscriberResults(
        subscriberId: subscriberId, courseId: courseId);
    result.fold((l) => emit(GetSubscriberResultsFailure(errmessage: l.message)),
        (results) {
      subscriberResults = results;
      emit(GetSubscriberResultsSuccess(results: results));
    });
  }

  Future<void> getSubscriberHighestScore({
    required String subscriberId,
    required String courseId,
  }) async {
    emit(GetSubscriberHighestScoreLoading());
    final result = await subscribersDetailsRepo.getSubscriberHighestScore(
        subscriberId: subscriberId, courseId: courseId);
    result.fold(
        (l) => emit(GetSubscriberHighestScoreFailure(errmessage: l.message)),
        (results) => emit(GetSubscriberHighestScoreSuccess(result: results)));
  }

  Future<void> getSubscriberLowestScore({
    required String subscriberId,
    required String courseId,
  }) async {
    emit(GetSubscriberLowestScoreLoading());
    final result = await subscribersDetailsRepo.getSubscriberLowestScore(
        subscriberId: subscriberId, courseId: courseId);
    result.fold(
        (l) => emit(GetSubscriberLowestScoreFailure(errmessage: l.message)),
        (results) => emit(GetSubscriberLowestScoreSuccess(result: results)));
  }

  void getSubscriberAverageScore() {
    double totalScore = 0;
    if (subscriberResults.isNotEmpty) {
      for (TestResultEntity result in subscriberResults) {
        totalScore += result.result;
      }
      emit(SubscriberAvrageCalculationSuccess(
        avrage: totalScore / subscriberResults.length,
      ));
    }
  }
}
