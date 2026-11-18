import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results/results_status_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/SubscribersDetailsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';

part 'subuscriber_details_state.dart';

class SubscriberDetailsCubit extends Cubit<SubscriberDetailsState> {
  SubscriberDetailsCubit({required this.subscribersDetailsRepo})
    : super(SubuscriberDetailsInitial());
  final SubscribersDetailsRepo subscribersDetailsRepo;
  List<TestResultEntity> subscriberResults = const [];

  Future<void> getSubscibersEnrolledCoursesForTeacher({
    required String contentCreatorId,
    required String subscriberId,
  }) async {
    emit(GetSubscibersEnrolledCoursesForTeacherLoading());
    final result = await subscribersDetailsRepo
        .getSubscibersEnrolledCoursesForTeacher(
          contentCreatorId: contentCreatorId,
          subscriberId: subscriberId,
        );
    result.fold(
      (failure) => emit(
        GetSubscibersEnrolledCoursesForTeacherFailure(
          errmessage: failure.message,
        ),
      ),
      (courses) =>
          emit(GetSubscibersEnrolledCoursesForTeacherSuccess(courses: courses)),
    );
  }

  Future<void> getSubscriberResults({
    required String subscriberId,
    required String courseId,
  }) async {
    emit(GetSubscriberResultsLoading());
    final result = await subscribersDetailsRepo.getSubscriberResults(
      subscriberId: subscriberId,
      courseId: courseId,
    );
    result.fold(
      (failure) =>
          emit(GetSubscriberResultsFailure(errmessage: failure.message)),
      (results) {
        subscriberResults = List.unmodifiable(results);
        final summary = SubscriberPerformanceSummary.fromResults(
          subscriberResults,
        );
        if (summary.resultDiscrepancyCount > 0) {}
        emit(
          GetSubscriberResultsSuccess(
            results: subscriberResults,
            summary: summary,
          ),
        );
      },
    );
  }

  Future<void> getSubscriberHighestScore({
    required String subscriberId,
    required String courseId,
  }) async {
    emit(GetSubscriberHighestScoreLoading());
    final result = await subscribersDetailsRepo.getSubscriberHighestScore(
      subscriberId: subscriberId,
      courseId: courseId,
    );
    result.fold(
      (failure) =>
          emit(GetSubscriberHighestScoreFailure(errmessage: failure.message)),
      (value) => emit(GetSubscriberHighestScoreSuccess(result: value)),
    );
  }

  Future<void> getSubscriberLowestScore({
    required String subscriberId,
    required String courseId,
  }) async {
    emit(GetSubscriberLowestScoreLoading());
    final result = await subscribersDetailsRepo.getSubscriberLowestScore(
      subscriberId: subscriberId,
      courseId: courseId,
    );
    result.fold(
      (failure) =>
          emit(GetSubscriberLowestScoreFailure(errmessage: failure.message)),
      (value) => emit(GetSubscriberLowestScoreSuccess(result: value)),
    );
  }

  void getSubscriberAverageScore() {
    if (subscriberResults.isEmpty) return;
    final mean =
        subscriberResults
            .map(ResultsStatusMapper.percentage)
            .reduce((left, right) => left + right) /
        subscriberResults.length;
    emit(SubscriberAvrageCalculationSuccess(avrage: mean));
  }
}
