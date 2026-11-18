import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

part 'my_course_rating_state.dart';

class MyCourseRatingCubit extends Cubit<MyCourseRatingState> {
  MyCourseRatingCubit({
    required this.courseFeedBacksRepo,
    required this.courseId,
    this.teacherId,
  }) : super(const MyCourseRatingState());

  final CourseFeedBacksRepo courseFeedBacksRepo;
  final String courseId;

  final String? teacherId;

  Future<void>? _loading;

  int _writeVersion = 0;

  Future<void> load({String? uid}) =>
      _loading ??= _load(uid).whenComplete(() => _loading = null);

  Future<void> _load(String? uid) async {
    final hadSummary = state.loadStatus == CourseRatingLoadStatus.loaded;
    if (!hadSummary) {
      emit(
        state.copyWith(
          loadStatus: CourseRatingLoadStatus.loading,
          errorMessage: null,
        ),
      );
    }
    final writeVersion = _writeVersion;
    final statsRequest = courseFeedBacksRepo.getCourseRatingStats(
      courseId: courseId,
    );
    final myFeedbackRequest = uid == null || uid.isEmpty
        ? Future.value(right<Failure, CoursefeedbackItemEntity?>(null))
        : courseFeedBacksRepo.getMyCourseFeedback(courseId: courseId, uid: uid);
    final statsResult = await statsRequest;
    final myFeedbackResult = await myFeedbackRequest;
    if (isClosed) return;

    final outdated = writeVersion != _writeVersion;

    final myFeedback = outdated
        ? state.myFeedback
        : myFeedbackResult.fold(
            (_) => state.myFeedback,
            (feedback) => feedback,
          );
    statsResult.fold(
      (failure) => emit(
        hadSummary
            ? state.copyWith(myFeedback: myFeedback, hasLoadedOnce: true)
            : state.copyWith(
                loadStatus: CourseRatingLoadStatus.failure,
                myFeedback: myFeedback,
                errorMessage: failure.message,
                hasLoadedOnce: true,
              ),
      ),
      (stats) => emit(
        state.copyWith(
          loadStatus: CourseRatingLoadStatus.loaded,
          stats: outdated ? state.stats : stats,
          myFeedback: myFeedback,
          errorMessage: null,
          hasLoadedOnce: true,
        ),
      ),
    );
  }

  Future<void> save({required int rating, required String text}) async {
    if (state.isBusy) return;
    _writeVersion++;
    emit(state.copyWith(action: CourseRatingAction.saving, errorMessage: null));
    final result = await courseFeedBacksRepo.saveMyCourseFeedback(
      courseId: courseId,
      teacherId: teacherId,
      rating: rating,
      text: text,
    );
    _writeVersion++;
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          action: CourseRatingAction.saveFailed,
          errorMessage: failure.message,
        ),
      ),
      (saved) => emit(
        state.copyWith(
          action: CourseRatingAction.saved,
          loadStatus: CourseRatingLoadStatus.loaded,
          stats: saved.stats,
          myFeedback: saved.feedback,
          hasLoadedOnce: true,
        ),
      ),
    );
  }

  Future<void> delete() async {
    if (state.isBusy || state.myFeedback == null) return;
    _writeVersion++;
    emit(
      state.copyWith(action: CourseRatingAction.deleting, errorMessage: null),
    );
    final result = await courseFeedBacksRepo.deleteMyCourseFeedback(
      courseId: courseId,
      teacherId: teacherId,
    );
    _writeVersion++;
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          action: CourseRatingAction.deleteFailed,
          errorMessage: failure.message,
        ),
      ),
      (stats) => emit(
        state.copyWith(
          action: CourseRatingAction.deleted,
          stats: stats ?? state.stats,
          myFeedback: null,
        ),
      ),
    );
  }
}
