import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

part 'course_feed_backs_state.dart';

class CourseFeedBacksCubit extends Cubit<CourseFeedBacksState> {
  CourseFeedBacksCubit({required this.courseFeedBacksRepo})
    : super(CourseFeedBacksInitial());
  final CourseFeedBacksRepo courseFeedBacksRepo;

  final List<CoursefeedbackItemEntity> _feedBacks = [];
  bool _hasMore = true;
  bool _isLoading = false;
  bool _hasLoadedOnce = false;

  List<CoursefeedbackItemEntity> get feedBacks => List.unmodifiable(_feedBacks);
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  bool get hasLoadedOnce => _hasLoadedOnce;

  Future<void> getCourseFeedBacks({
    required String courseId,
    required bool isPaginate,
  }) => _load(courseId: courseId, isPaginate: isPaginate, showLoading: true);

  Future<void> refresh({required String courseId}) =>
      _load(courseId: courseId, isPaginate: false, showLoading: false);

  Future<void> _load({
    required String courseId,
    required bool isPaginate,
    required bool showLoading,
  }) async {
    if (_isLoading || (isPaginate && !_hasMore)) return;
    _isLoading = true;
    if (showLoading) {
      emit(CourseFeedBacksGetFeedBackLoading(isPaginate: isPaginate));
    }
    final result = await courseFeedBacksRepo.getCourseFedBacks(
      courseId: courseId,
      isPaginate: isPaginate,
    );
    _isLoading = false;
    if (isClosed) return;
    if (!isPaginate) _hasLoadedOnce = true;
    result.fold(
      (failure) {
        emit(
          CourseFeedBacksGetFeedBackFailure(
            errMessage: failure.message,
            isPaginate: isPaginate,
          ),
        );
      },
      (response) {
        if (!response.isPaginate) _feedBacks.clear();
        final seen = _feedBacks.map((feedback) => feedback.uid).toSet();
        _feedBacks.addAll(
          response.feedBacks.where((feedback) => seen.add(feedback.uid)),
        );
        _hasMore = response.hasMore;
        emit(CourseFeedBacksGetFeedBackSuccess(response: response));
      },
    );
  }

  void upsertLocally(CoursefeedbackItemEntity feedback) {
    final index = _feedBacks.indexWhere((item) => item.uid == feedback.uid);
    if (index >= 0) {
      _feedBacks[index] = feedback;
    } else {
      _feedBacks.insert(0, feedback);
    }
    _emitLocalChange();
  }

  void removeLocally(String uid) {
    _feedBacks.removeWhere((item) => item.uid == uid);
    _emitLocalChange();
  }

  void _emitLocalChange() {
    if (isClosed) return;
    emit(
      CourseFeedBacksGetFeedBackSuccess(
        response: GetCourseFeedBacksResponseEntity(
          feedBacks: List.of(_feedBacks),
          hasMore: _hasMore,
          isPaginate: false,
        ),
      ),
    );
  }
}
